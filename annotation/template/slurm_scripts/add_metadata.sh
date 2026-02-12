#!/bin/bash
# FILENAME = add_metadata_{EXP}.sh 

#SBATCH -A mcb130189
#SBATCH -J add_metadata_{EXP}
#SBATCH -p wholenode
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/add_metadata.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/add_metadata.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/00_add_metadata.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/00_add_metadata_cps.ipynb \
    -p EXPERIMENT {EXP} \
    -p suffix {SUFFIX}

echo "Done"