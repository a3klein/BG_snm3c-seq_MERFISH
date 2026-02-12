#!/bin/bash
# FILENAME = mat_str_region_calling.sh 

#SBATCH -A mcb130189
#SBATCH -J mat_str_regions
#SBATCH -p wholenode
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/mat_str_regions.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/mat_str_regions.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/call_regions_mat-str.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/call_regions_mat-str_cps.ipynb \
    -k preprocessing

echo "Done Calculating Mat - Str Regions"
