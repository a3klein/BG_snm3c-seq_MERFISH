#!/bin/bash
# FILENAME: start_script.sh
# DESCRIPTION: This script loads the spatialdata object for a given sample

#SBATCH -A mcb130189
#SBATCH -J start_GP_UWA7648
#SBATCH -p wholenode
#SBATCH -t 00:20:00
#SBATCH --nodes=1
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/GP/start_GP_UWA7648.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/GP/start_GP_UWA7648.out

# Load the necessary modules
module load modtree/cpu
module list 

export PATH="/home/x-aklein2/.pixi/bin:$PATH"

cd /anvil/projects/x-mcb130189/aklein/SPIDA
echo "Setting up .zarr file for region UWA7648 of experiment GP"


pixi run -e preprocessing \
    python -m spida.S ingest-region \
    202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
    region_UWA7648 \
    --plot
