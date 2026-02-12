#!/bin/bash
# FILENAME: start_script.sh
# DESCRIPTION: This script loads the spatialdata object for a given sample

#SBATCH -A mcb130189
#SBATCH -J start_Ren41_UCI5224
#SBATCH -p wholenode
#SBATCH -t 00:20:00
#SBATCH --nodes=1
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren41/start_Ren41_UCI5224.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren41/start_Ren41_UCI5224.out

# Load the necessary modules
module load modtree/cpu
module list 

export PATH="/home/x-aklein2/.pixi/bin:$PATH"

cd /anvil/projects/x-mcb130189/aklein/SPIDA
echo "Setting up .zarr file for region UCI5224 of experiment Ren41"


pixi run -e preprocessing \
    python -m spida.S ingest-region \
    202507041709_20250704M211BICANRen41_VMSC32010 \
    region_UCI5224Q04SubT \
    --plot
