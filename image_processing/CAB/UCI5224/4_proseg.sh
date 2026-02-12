#!/bin/bash
# FILENAME = proseg_v4.sh 

#SBATCH -A mcb130189
#SBATCH -J proseg_CAB_UCI5224
#SBATCH -p wholenode
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/CAB/proseg_CAB_UCI5224.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/CAB/proseg_CAB_UCI5224.out
#SBATCH --export=ALL


module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

####
echo "Running ProSeg V3.8"
####

PREFIX=proseg_fv38

# SEGMENTATION
pixi run -e preprocessing \
    python -m spida.S run \
    proseg \
    202506171319_BICAN4x1-CAB-E01_VMSC31810 \
    region_UCI5224-CAB-E1 \
    --input_dir /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN4x1-CAB-E01_VMSC31810/cellpose/ \
    --output_dir /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN4x1-CAB-E01_VMSC31810/${PREFIX} \
    --kwargs \
    voxel-layers=7 \
    ncomponents=10 \
    enforce-connectivity=True \
    nuclear-reassignment-prob=0.05 \
    cell-compactness=0.05 \
    diffusion-probability=0.01

# LOAD PROSEG SEGMENTATION
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506171319_BICAN4x1-CAB-E01_VMSC31810 \
    region_UCI5224-CAB-E1 \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN4x1-CAB-E01_VMSC31810/${PREFIX} \
    --type proseg \
    --prefix_name ${PREFIX} \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506171319_BICAN4x1-CAB-E01_VMSC31810 \
    region_UCI5224-CAB-E1 \
    ${PREFIX} \
    --seg_fam proseg \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_proseg.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506171319_BICAN4x1-CAB-E01_VMSC31810 \
    region_UCI5224-CAB-E1 \
    ${PREFIX} \
    --suffix _filt \
    --plot

# ALLCOOLS Integration 
pixi run -e preprocessing python src/spida/I/main.py allcools-integration-region \
    202506171319_BICAN4x1-CAB-E01_VMSC31810 \
    region_UCI5224-CAB-E1 \
    ${PREFIX} \
    /home/x-aklein2/projects/aklein/BICAN/data/reference/AIT/AIT_CA_filtered.h5ad \
    --gene_rename_dict /home/x-aklein2/projects/aklein/BICAN/data/reference/AIT/BG_gene_rename.json \
    --max_cells_per_cluster 3000 \
    --min_cells_per_cluster 20 \
    --top_deg_genes 50 \
    --rna_cell_type_column Subclass \
    --qry_cluster_column base_leiden \
    --run_joint_embeddings \
    --plot
