#!/bin/bash
# FILENAME = rethresh.sh 

#SBATCH -A mcb130189
#SBATCH -J rethresh_cp2
#SBATCH -p shared
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2.out
#SBATCH --export=ALL


module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA


# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506221112_BICAN-4x1-MGM1-E-03_VMSC31910 \
    region_UWA7648 \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221112_BICAN-4x1-MGM1-E-03_VMSC31910/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506221112_BICAN-4x1-MGM1-E-03_VMSC31910 \
    region_UWA7648 \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506221112_BICAN-4x1-MGM1-E-03_VMSC31910 \
    region_UWA7648 \
    CPS \
    --suffix filt \
    --plot