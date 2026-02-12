#!/bin/bash
# FILENAME = proseg_v4.sh 

#SBATCH -A mcb130189
#SBATCH -J proseg_PU_region_UCI4723
#SBATCH -p wholenode
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/PU/proseg_PU_region_UCI4723_mkup.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/PU/proseg_PU_region_UCI4723_mkup.out
#SBATCH --export=ALL


module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

####
echo "Running ProSeg V3.8"
####

PREFIX=proseg_fv38

# ALLCOOLS Integration 
pixi run -e preprocessing python src/spida/I/main.py allcools-integration-region \
    202506151211_BICAN-4x1-PU-01_VMSC31910 \
    region_UCI4723 \
    ${PREFIX} \
    /home/x-aklein2/projects/aklein/BICAN/data/reference/AIT/AIT_PU_filtered.h5ad \
    --gene_rename_dict /home/x-aklein2/projects/aklein/BICAN/data/reference/AIT/BG_gene_rename.json \
    --max_cells_per_cluster 2000 \
    --min_cells_per_cluster 20 \
    --top_deg_genes 100 \
    --rna_cell_type_column Subclass \
    --qry_cluster_column base_leiden \
    --run_joint_embeddings \
    --plot

# ALLCOOLS Integration 
pixi run -e preprocessing python src/spida/I/main.py allcools-integration-region \
    202506191452_20250619M205BICANRen36_VMSC32110 \
    region_UCI2424Q02Pu \
    ${PREFIX} \
    /home/x-aklein2/projects/aklein/BICAN/data/reference/AIT/AIT_PU.h5ad \
    --gene_rename_dict /home/x-aklein2/projects/aklein/BICAN/data/reference/AIT/BG_gene_rename.json \
    --max_cells_per_cluster 2000 \
    --min_cells_per_cluster 20 \
    --top_deg_genes 100 \
    --rna_cell_type_column Subclass \
    --qry_cluster_column base_leiden \
    --run_joint_embeddings \
    --plot
