#!/bin/bash
# FILENAME: start_script.sh
# DESCRIPTION: This script loads the spatialdata object for a given sample

#SBATCH -A mcb130189
#SBATCH -J start_NAC_region_UCI4723-NAC-E5
#SBATCH -p wholenode
#SBATCH -t 00:20:00
#SBATCH --nodes=1
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/NAC/start_NAC_region_UCI4723-NAC-E5.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/NAC/start_NAC_region_UCI4723-NAC-E5.out

# Load the necessary modules
module load modtree/cpu
module list 

export PATH="/home/x-aklein2/.pixi/bin:$PATH"

cd /anvil/projects/x-mcb130189/aklein/SPIDA
echo "Setting up .zarr file for region region_UCI4723-NAC-E5 of experiment NAC"


pixi run -e preprocessing \
    python -m spida.S ingest-region \
    202506221112_BICAN4x1-NAC-E05_VMSC31810 \
    region_UCI4723-NAC-E5 \
    --plot
