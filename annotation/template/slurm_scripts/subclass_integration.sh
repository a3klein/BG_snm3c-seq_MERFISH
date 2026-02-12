#!/bin/bash
# FILENAME = subclass_integration_{EXP}.sh 

#SBATCH -A mcb130189
#SBATCH -J subclass_integration_{EXP}
#SBATCH -p wholenode
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/subclass_integration.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/annot/{EXP}/subclass_integration.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/integration/seurat_integration.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/base_r2_subclass/seurat_integration.ipynb \
    -p EXP {EXP} \
    -p REF_EXP {REF_EXP} \
    -p ref_cell_type Subclass \
    -p spatial_cell_type base_round2_leiden \
    -p topn 100 \
    -p outdir /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/base_r2_subclass/ \

echo "Done"


pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/integration/seurat_integration.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/base_r1_subclass/seurat_integration.ipynb \
    -p EXP {EXP} \
    -p REF_EXP {REF_EXP} \
    -p ref_cell_type Subclass \
    -p spatial_cell_type base_round1_leiden \
    -p topn 20 \
    -p outdir /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/base_r1_subclass/ \

echo "Done"

# pixi run \
#     papermill \
#     /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/integration/seurat_integration.ipynb \
#     /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/scviva_r1_subclass/seurat_integration.ipynb \
#     -p spatial_adata_path /home/x-aklein2/projects/aklein/BICAN/BG/data/annotation/BICAN_BG_{EXP}/{EXP}.h5ad_scviva.h5ad \
#     -p EXP {EXP} \
#     -p REF_EXP {REF_EXP} \
#     -p ref_cell_type Subclass \
#     -p spatial_cell_type scVIVA_round1_leiden \
#     -p topn 200 \
#     -p outdir /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/scviva_r1_subclass/ \
#     -p spatial_downsample 2000 \

# echo "Done"

# pixi run \
#     papermill \
#     /home/x-aklein2/projects/aklein/BICAN/BG/annotation/template/integration/seurat_integration.ipynb \
#     /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/scviva_r2_subclass/seurat_integration.ipynb \
#     -p spatial_adata_path /home/x-aklein2/projects/aklein/BICAN/BG/data/annotation/BICAN_BG_{EXP}/{EXP}.h5ad_scviva.h5ad \
#     -p EXP {EXP} \
#     -p REF_EXP {REF_EXP} \
#     -p ref_cell_type Subclass \
#     -p spatial_cell_type scVIVA_round2_leiden \
#     -p topn 50 \
#     -p outdir /home/x-aklein2/projects/aklein/BICAN/BG/annotation/execute/{EXP}/notebooks/scviva_r2_subclass/ \
#     -p spatial_downsample 1000 \

# echo "Done"
