#!/bin/bash
# FILENAME = subclass_scviva.sh 

#SBATCH -A mcb130189-gpu
#SBATCH -J {EXP}_subclass_scviva
#SBATCH -p gpu
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=64
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/subclass_scviva.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/subclass_scviva.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/00_subclass_scviva.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/00_subclass_scviva.ipynb \
    -p EXPERIMENT {EXP} \
    -k preprocessing-gpu

echo "Done"
