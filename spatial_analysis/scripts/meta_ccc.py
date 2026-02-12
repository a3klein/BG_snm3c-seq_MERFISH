### Written with ChatGPT help ###
## To make this callable from the command line maybe add some argparse / click functionality later ## 

"""
Meta-analysis of cell–cell contact z-scores across spatial transcriptomics experiments.
Performs:
  1. Direction-specific random-effects meta-analysis within each brain region
  2. Region-wise moderator tests (do effects differ across regions?)
  3. Multilevel heterogeneity partitioning (donor vs experiment)
  4. Directional asymmetry summary (A→B vs B→A)

Author: eckerlab
"""

# -------------------------------------------------------------------------
#  Imports
# -------------------------------------------------------------------------
from pathlib import Path
import pandas as pd
import numpy as np
from scipy.stats import norm 
import statsmodels.api as sm
from statsmodels.regression.mixed_linear_model import MixedLM
from itertools import combinations
import warnings
warnings.filterwarnings("ignore")

# -------------------------------------------------------------------------
#  Load input data
# -------------------------------------------------------------------------

DIR = Path("/home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/meta_contacts")
INFILE = DIR / "contacts_meta_input.csv"   # combined table of all donor/region/replicate results
df = pd.read_csv(INFILE)

# Verify required columns exist
req = {
    "cell_type1", "cell_type2", "z_score", "pval",
    "permutation_mean", "permutation_std",
    "contact_count", "pval-adjusted", "fold-change"
}
missing = req - set(df.columns)
if missing:
    raise ValueError(f"Missing columns: {missing}")

# Ensure donor / brain_region / replicate exist; create placeholders if not
for col in ["donor", "brain_region", "replicate"]:
    if col not in df.columns:
        df[col] = "NA"

# -------------------------------------------------------------------------
#  Preprocessing
# -------------------------------------------------------------------------

# (1) Construct a *directional* interaction ID.
# We now keep order: A→B is distinct from B→A.
df["pair"] = (
    df["cell_type1"].astype(str).str.strip()
    + "→"
    + df["cell_type2"].astype(str).str.strip()
)

# (2) Drop entries with unstable null distributions.
# If permutation_mean ≈ 0, fold-changes blow up and z-scores aren’t meaningful.
df = df[df["permutation_mean"] > 1.0].copy()

# (3) Define effect size (yi) and its sampling variance (vi).
# For permutation z-scores, the variance under the null ≈ 1.
df = df.assign(yi=df["z_score"].astype(float), vi=1.0)

# Unique ID for each experiment replicate
df["study_id"] = (
    df["donor"].astype(str) + "|" +
    df["brain_region"].astype(str) + "|" +
    df["replicate"].astype(str)
)

# -------------------------------------------------------------------------
#  Helper functions
# -------------------------------------------------------------------------

def dl_tau2(yi, vi):
    """
    DerSimonian–Laird estimator of between-study variance τ².
    """
    w = 1.0 / vi
    ybar = np.sum(w * yi) / np.sum(w)
    Q = np.sum(w * (yi - ybar) ** 2)
    k = len(yi)
    c = np.sum(w) - np.sum(w ** 2) / np.sum(w)
    tau2 = max(0.0, (Q - (k - 1)) / c) if c > 0 else 0.0
    return tau2, Q

def re_meta(yi, vi):
    """
    Run a random-effects meta-analysis given effect sizes yi and variances vi.
    Returns pooled mean, SE, z-statistic, p-value, CI, τ², and I².
    """
    tau2, Q = dl_tau2(yi, vi)
    w_star = 1.0 / (vi + tau2)
    mu = np.sum(w_star * yi) / np.sum(w_star)
    se = np.sqrt(1.0 / np.sum(w_star))
    z = mu / se if se > 0 else np.nan
    p = 2 * norm.sf(abs(z)) if np.isfinite(z) else np.nan
    ci_lb, ci_ub = mu - 1.96 * se, mu + 1.96 * se
    k = len(yi)
    I2 = max(0.0, (Q - (k - 1)) / Q) * 100 if (k > 1 and Q > 0) else 0.0
    return dict(mu=mu, se=se, z=z, p=p,
                ci_lb=ci_lb, ci_ub=ci_ub,
                tau2=tau2, Q=Q, k=k, I2=I2)

# -------------------------------------------------------------------------
#  (1) Random-effects meta-analysis within each region
# -------------------------------------------------------------------------
region_rows = []
for pair, dfg in df.groupby("pair"):
    for region, dfr in dfg.groupby("brain_region"):
        # Need ≥2 experiments to estimate heterogeneity
        if len(dfr) >= 2:
            res = re_meta(dfr["yi"].values, dfr["vi"].values)
            res.update(pair=pair, brain_region=region)
            region_rows.append(res)

per_region = pd.DataFrame(region_rows)
if len(per_region):
    # Benjamini–Hochberg FDR correction within all tests
    per_region["p_fdr"] = sm.stats.multipletests(per_region["p"], method="fdr_bh")[1]
    per_region.to_csv(DIR / "meta_region_pooled.csv", index=False)
print("Wrote meta_region_pooled.csv (pooled z per pair × region)")

# -------------------------------------------------------------------------
#  (2) Region moderator analysis: do effects differ across regions?
# -------------------------------------------------------------------------
mod_rows, contrast_rows = [], []
for pair, dfg in df.groupby("pair"):
    regs = sorted(dfg["brain_region"].unique())
    if len(regs) < 2:
        continue
    # Create design matrix: one column per region
    X = pd.get_dummies(dfg["brain_region"], drop_first=False)
    w = 1.0 / dfg["vi"].values  # weights
    model = sm.WLS(dfg["yi"].values, X, weights=w).fit()

    # Compare to an intercept-only model (grand mean) → omnibus F-test
    X0 = np.ones((len(dfg), 1))
    model0 = sm.WLS(dfg["yi"].values, X0, weights=w).fit()
    anov = sm.stats.anova_lm(model0, model)
    p_between = float(anov["Pr(>F)"].iloc[-1])
    mod_rows.append({"pair": pair, "p_between": p_between})

    # Pairwise region contrasts
    coefs, cov = model.params.values, model.cov_params().values
    cols = X.columns.tolist()
    for a, b in combinations(cols, 2):
        L = np.zeros(len(cols))
        L[cols.index(a)], L[cols.index(b)] = 1, -1
        est = float(L @ coefs)
        se = float(np.sqrt(L @ cov @ L))
        z = est / se if se > 0 else np.nan
        p = 2 * norm.sf(abs(z)) if np.isfinite(z) else np.nan
        contrast_rows.append({
            "pair": pair, "region1": a, "region2": b,
            "contrast_est": est, "contrast_se": se, "z": z, "p_contrast": p
        })

mod = pd.DataFrame(mod_rows)
if len(mod):
    mod["p_between_fdr"] = sm.stats.multipletests(mod["p_between"], method="fdr_bh")[1]
    mod.to_csv(DIR / "meta_region_moderator.csv", index=False)
print("Wrote meta_region_moderator.csv (omnibus region tests)")

contr = pd.DataFrame(contrast_rows)
if len(contr):
    contr["p_contrast_fdr"] = sm.stats.multipletests(contr["p_contrast"], method="fdr_bh")[1]
    contr.to_csv(DIR / "meta_region_pairwise_contrasts.csv", index=False)
print("Wrote meta_region_pairwise_contrasts.csv (pairwise region contrasts)")

# -------------------------------------------------------------------------
#  (3) Multilevel heterogeneity: donor vs experiment-within-donor
# -------------------------------------------------------------------------
het_rows = []
for pair, dfg in df.groupby("pair"):
    if dfg["donor"].nunique() < 2 or dfg["study_id"].nunique() < 3:
        continue
    try:
        endog = dfg["yi"].values
        exog = np.ones((len(dfg), 1))  # intercept
        # Random intercept for donor; additional variance component for study_id nested in donor
        vc = {"study": pd.Categorical(dfg["study_id"])}
        m = MixedLM(endog, exog, groups=dfg["donor"], vc_formula=vc)
        fit = m.fit(reml=True, method="lbfgs", maxiter=200, disp=False)

        # Extract variance components
        var_donor = float(fit.cov_re.iloc[0, 0]) if hasattr(fit, "cov_re") else np.nan
        var_study = float(fit.vcomp["study"]) if "study" in fit.vcomp.index else np.nan
        tau2_total = np.nansum([var_donor, var_study])
        sigma2_within = 1.0  # within-study variance
        I2_total = 100 * tau2_total / (tau2_total + sigma2_within)
        I2_donor = 100 * var_donor / (tau2_total + sigma2_within)
        I2_exp = 100 * var_study / (tau2_total + sigma2_within)
        het_rows.append({
            "pair": pair,
            "tau2_donor": var_donor,
            "tau2_experiment": var_study,
            "tau2_total": tau2_total,
            "I2_total": I2_total,
            "I2_donor": I2_donor,
            "I2_experiment": I2_exp
        })
    except Exception:
        het_rows.append({
            "pair": pair, "tau2_donor": np.nan,
            "tau2_experiment": np.nan, "tau2_total": np.nan,
            "I2_total": np.nan, "I2_donor": np.nan, "I2_experiment": np.nan
        })

het = pd.DataFrame(het_rows)
if len(het):
    het.to_csv(DIR / "meta_multilevel_heterogeneity.csv", index=False)
print("Wrote meta_multilevel_heterogeneity.csv (variance partition)")

# -------------------------------------------------------------------------
#  (4) Directional asymmetry summary  A→B  vs  B→A
# -------------------------------------------------------------------------
def split_pair(pair):
    """Split 'A→B' into ['A', 'B']."""
    if "→" in pair:
        return pair.split("→", 1)
    return [pair, ""]

def find_reciprocal(pair):
    """Return reciprocal 'B→A'."""
    a, b = split_pair(pair)
    return f"{b}→{a}"

def classify_asym(row):
    """Heuristic label based on z-difference."""
    if pd.isna(row["z_diff"]):
        return "missing"
    if abs(row["z_diff"]) < 0.5:
        return "Both (symmetric)"
    elif row["z_diff"] > 0.5:
        return "Directional (A→B dominates)"
    else:
        return "Directional (B→A dominates)"

meta = pd.read_csv(DIR / "meta_region_pooled.csv")
asym_rows = []

# For each region, compare each pair with its reciprocal
for region, dfreg in meta.groupby("brain_region"):
    pairs = set(dfreg["pair"])
    for pair in pairs:
        recip = find_reciprocal(pair)
        a, b = split_pair(pair)
        dat_a = dfreg.loc[dfreg["pair"] == pair]
        dat_b = dfreg.loc[dfreg["pair"] == recip]

        if dat_a.empty and dat_b.empty:
            continue

        row = {
            "brain_region": region,
            "pair": pair,
            "reciprocal": recip,
            "cell_type1": a,
            "cell_type2": b,
            "z_AB": dat_a["mu"].iloc[0] if not dat_a.empty else np.nan,
            "z_BA": dat_b["mu"].iloc[0] if not dat_b.empty else np.nan,
            "p_AB": dat_a["p"].iloc[0] if not dat_a.empty else np.nan,
            "p_BA": dat_b["p"].iloc[0] if not dat_b.empty else np.nan,
            "I2_AB": dat_a["I2"].iloc[0] if not dat_a.empty else np.nan,
            "I2_BA": dat_b["I2"].iloc[0] if not dat_b.empty else np.nan,
        }

        # Differences
        row["z_diff"] = (
            row["z_AB"] - row["z_BA"]
            if pd.notna(row["z_AB"]) and pd.notna(row["z_BA"]) else np.nan
        )
        if pd.notna(row["p_AB"]) and pd.notna(row["p_BA"]) and row["p_AB"] > 0 and row["p_BA"] > 0:
            row["log10_p_ratio"] = np.log10(row["p_BA"] / row["p_AB"])
        else:
            row["log10_p_ratio"] = np.nan

        # Classification
        if dat_a.empty and not dat_b.empty:
            row["asym_class"] = "B→A only"
        elif not dat_a.empty and dat_b.empty:
            row["asym_class"] = "A→B only"
        else:
            row["asym_class"] = classify_asym(row)

        asym_rows.append(row)

asym = pd.DataFrame(asym_rows)
if len(asym):
    asym["abs_z_diff"] = abs(asym["z_diff"])
    asym["dominant_direction"] = np.where(
        asym["z_diff"] > 0, "A→B",
        np.where(asym["z_diff"] < 0, "B→A", "none")
    )
    asym = asym.sort_values(["brain_region", "abs_z_diff"], ascending=[True, False])
    asym.to_csv(DIR / "meta_directional_asymmetry.csv", index=False)
    print("Wrote meta_directional_asymmetry.csv (A→B vs B→A)")
else:
    print("No reciprocal pairs found for asymmetry summary.")
