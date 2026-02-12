#!/bin/bash
# FILENAME: start_script.sh
# DESCRIPTION: This script loads the spatialdata object for a given sample

#SBATCH -A mcb130189
#SBATCH -J start_Ren40_UCI2424
#SBATCH -p wholenode
#SBATCH -t 00:20:00
#SBATCH --nodes=1
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren40/start_Ren40_UCI2424.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren40/start_Ren40_UCI2424.out

# Load the necessary modules
module load modtree/cpu
module list 

export PATH="/home/x-aklein2/.pixi/bin:$PATH"

cd /anvil/projects/x-mcb130189/aklein/SPIDA
echo "Setting up .zarr file for region UCI2424 of experiment Ren40"


pixi run -e preprocessing \
    python -m spida.S ingest-region \
    202506301111_20250630M210BICANRen40_VMSC32010 \
    region_UCI2424Q04NAC \
    --plot
