#!/bin/bash
# FILENAME = rethresh.sh 

#SBATCH -A mcb130189
#SBATCH -J rethresh_cp2_GP
#SBATCH -p shared
#SBATCH --time=2:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_GP.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_GP.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\n Processing 202506171319_BICAN-4x1-GP-E-05_VMSC31910 - region_UCI2424 -- COUNTER 1 / 8 \n"

# Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI2424 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN-4x1-GP-E-05_VMSC31910/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI2424 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI2424 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506171319_BICAN-4x1-GP-E-05_VMSC31910 - region_UCI4723 -- COUNTER 2 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI4723 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN-4x1-GP-E-05_VMSC31910/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI4723 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI4723 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506171319_BICAN-4x1-GP-E-05_VMSC31910 - region_UCI5224 -- COUNTER 3 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI5224 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN-4x1-GP-E-05_VMSC31910/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI5224 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UCI5224 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506171319_BICAN-4x1-GP-E-05_VMSC31910 - region_UWA7648 -- COUNTER 4 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UWA7648 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN-4x1-GP-E-05_VMSC31910/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UWA7648 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506171319_BICAN-4x1-GP-E-05_VMSC31910 \
#     region_UWA7648 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506221225_20250622M206BICANRen37_VMSC32010 - region_UCI2424Q04GP -- COUNTER 5 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221225_20250622M206BICANRen37_VMSC32010 \
#     region_UCI2424Q04GP \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221225_20250622M206BICANRen37_VMSC32010/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221225_20250622M206BICANRen37_VMSC32010 \
#     region_UCI2424Q04GP \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506221225_20250622M206BICANRen37_VMSC32010 \
#     region_UCI2424Q04GP \
#     CPS \
#     --suffix filt \
#     --plot


echo -e "\n Processing 202506221225_20250622M206BICANRen37_VMSC32010 - region_UCI4723Q04GP -- COUNTER 6 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UCI4723Q04GP \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221225_20250622M206BICANRen37_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UCI4723Q04GP \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UCI4723Q04GP \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202506221225_20250622M206BICANRen37_VMSC32010 - region_UCI5224Q04GP -- COUNTER 7 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UCI5224Q04GP \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221225_20250622M206BICANRen37_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UCI5224Q04GP \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UCI5224Q04GP \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202506221225_20250622M206BICANRen37_VMSC32010 - region_UWA7648Q04GP -- COUNTER 8 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UWA7648Q04GP \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221225_20250622M206BICANRen37_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UWA7648Q04GP \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506221225_20250622M206BICANRen37_VMSC32010 \
    region_UWA7648Q04GP \
    CPS \
    --suffix filt \
    --plot

