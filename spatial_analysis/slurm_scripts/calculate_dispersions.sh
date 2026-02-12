#!/bin/bash
# FILENAME = dispersion.sh 

#SBATCH -A mcb130189
#SBATCH -J dispersion
#SBATCH -p wholenode
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/dispersion.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/dispersion.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/calculate_dispersion.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/calculate_dispersion_r15.ipynb \
    -k preprocessing

echo "Done Calculating Dispersion"
