#!/bin/bash
# FILENAME = strmat_morphogam.sh 

#SBATCH -A mcb130189
#SBATCH -J strmat_morphogam_gr_brs
#SBATCH -p wholenode
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/str_mat_morphogam_gr_brs.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/str_mat_morphogam_gr_brs.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/morphogam_runner.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_morphogam_gr_brs.ipynb\
    -p AD_PATH /home/x-aklein2/projects/aklein/BICAN/BG/data/BICAN_BG_CPS.h5ad \
    -p OUTDIR /home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/morphogam_gr_brs \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/CPS/morphogam_gr_brs \
    -p REP_KEY brain_region_corr \
    -p SKIP_REPS "CaT" \
    -p CELLTYPE_KEY Group \
    -p AXIS MS_NORM \
    -p min_cells 40 \
    -p N_WORKERS 8 \
    -k dist

echo "Done Calculating MS MorphoGAM"


# R_NUM_CORES -  cores per R tradeSeq call
# N_WORKERS - number of parallel tradeSeq calls