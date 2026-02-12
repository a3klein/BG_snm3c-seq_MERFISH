#!/bin/bash
# FILENAME = group_annot.sh 

#SBATCH -A mcb130189
#SBATCH -J cps_{EXP}_{DONOR}_lab_annot
#SBATCH -p wholenode
#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/region_donor_lab_cps/{EXP}_{DONOR}.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/region_donor_lab_cps/{EXP}_{DONOR}.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/01_region_donor_lab_annot.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/region_donor_lab_cps2/{EXP}_{DONOR}_{LAB1}/integrate.ipynb \
    -p EXP {EXP} \
    -p REF_EXP {REF_EXP} \
    -p DONOR {DONOR} \
    -p LAB {LAB1} \
    -p spatial_adata_path /home/x-aklein2/projects/aklein/BICAN/BG/data/annotation/BICAN_BG_{{EXP}}_CPSfilt/{{EXP}}.h5ad \
    -p save_path /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/region_donor_lab_cps2 \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/region_donor_lab_cps2 \
    -k preprocessing

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/01_region_donor_lab_annot.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/region_donor_lab_cps2/{EXP}_{DONOR}_{LAB2}/integrate.ipynb \
    -p EXP {EXP} \
    -p REF_EXP {REF_EXP} \
    -p LAB {LAB2} \
    -p DONOR {DONOR} \
    -p spatial_adata_path /home/x-aklein2/projects/aklein/BICAN/BG/data/annotation/BICAN_BG_{{EXP}}_CPSfilt/{{EXP}}.h5ad \
    -p save_path /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/region_donor_lab_cps2 \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/region_donor_lab_cps2 \
    -k preprocessing


# -p spatial_adata_path /home/x-aklein2/projects/aklein/BICAN/BG/data/annotation/BICAN_BG_{{EXP}}_cellpose_SAM_filt/{{EXP}}.h5ad \