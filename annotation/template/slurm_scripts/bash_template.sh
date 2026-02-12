#!/bin/bash
# FILENAME = group_annot.sh 

#SBATCH -A mcb130189
#SBATCH -J {EXP}_group_annot
#SBATCH -p wholenode
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/group_annot.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/group_annot.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA
