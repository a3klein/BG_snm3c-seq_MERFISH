#!/bin/bash
# FILENAME: start_script.sh
# DESCRIPTION: This script loads the spatialdata object for a given sample

#SBATCH -A mcb130189
#SBATCH -J start_CAT_UCI5224
#SBATCH -p wholenode
#SBATCH -t 00:20:00
#SBATCH --nodes=1
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/CAT/start_CAT_UCI5224.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/CAT/start_CAT_UCI5224.out

# Load the necessary modules
module load modtree/cpu
module list 

export PATH="/home/x-aklein2/.pixi/bin:$PATH"

cd /anvil/projects/x-mcb130189/aklein/SPIDA
echo "Setting up .zarr file for region UCI5224 of experiment CAT"


pixi run -e preprocessing \
    python -m spida.S ingest-region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-5224 \
    --plot
