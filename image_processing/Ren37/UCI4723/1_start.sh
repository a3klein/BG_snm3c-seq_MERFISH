#!/bin/bash
# FILENAME: start_script.sh
# DESCRIPTION: This script loads the spatialdata object for a given sample

#SBATCH -A mcb130189
#SBATCH -J start_Ren37_UCI4723
#SBATCH -p wholenode
#SBATCH -t 00:20:00
#SBATCH --nodes=1
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren37/start_Ren37_UCI4723.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren37/start_Ren37_UCI4723.out

# Load the necessary modules
module load modtree/cpu
module list 

export PATH="/home/x-aklein2/.pixi/bin:$PATH"

cd /anvil/projects/x-mcb130189/aklein/SPIDA
echo "Setting up .zarr file for region UCI4723 of experiment Ren37"


pixi run -e preprocessing \
    python -m spida.S ingest-region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UCI4723Q04GP \
    --plot
