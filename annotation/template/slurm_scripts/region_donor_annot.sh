#!/bin/bash
# FILENAME = group_annot.sh 

#SBATCH -A mcb130189
#SBATCH -J {EXP}_{DONOR}_annot
#SBATCH -p wholenode
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/region_donor/{EXP}_{DONOR}.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/region_donor/{EXP}_{DONOR}.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/01_region_donor_annot.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/region_donor/{EXP}_{DONOR}/integrate.ipynb \
    -p EXP {EXP} \
    -p REF_EXP {REF_EXP} \
    -p DONOR {DONOR} \
    -k preprocessing_bp