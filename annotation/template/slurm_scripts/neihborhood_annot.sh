#!/bin/bash
# FILENAME = neighb_annot.sh 

#SBATCH -A mcb130189
#SBATCH -J {EXP}_neighb_annot
#SBATCH -p wholenode
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/neighb_annot.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/neighb_annot.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/01_neighborhood_annot.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/01_neighborhood_annot.ipynb \
    -p EXP {EXP} \
    -p REF_EXP {REF_EXP} \
    -p max_cells_per_cluster 15000 \
    -p min_cells_per_cluster 200 \
    -p rna_cell_type_column Is_Neuron \
    -k preprocessing

echo "Done"
