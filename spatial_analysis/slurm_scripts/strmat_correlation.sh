#!/bin/bash
# FILENAME = strmat_corr.sh 

#SBATCH -A mcb130189
#SBATCH -J strmat_corr
#SBATCH -p shared
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/str_mat_corr.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/str_mat_corr.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/regional_ms_corr.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_corr_uci2424.ipynb\
    -p DONOR UCI2424 \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/regions/ms_corr_rna_uci2424 \
    -k preprocessing

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/regional_ms_corr.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_corr_uci4723.ipynb\
    -p DONOR UCI4723 \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/regions/ms_corr_rna_uci4723 \
    -k preprocessing


pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/regional_ms_corr.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_corr_uci5224.ipynb\
    -p DONOR UCI5224 \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/regions/ms_corr_rna_uci5224 \
    -k preprocessing


pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/regional_ms_corr.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_corr_uwa7648.ipynb\
    -p DONOR UWA7648 \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/regions/ms_corr_rna_uwa7648 \
    -k preprocessing

echo "Done Calculating MS Corr"
