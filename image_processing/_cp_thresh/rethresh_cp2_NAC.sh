#!/bin/bash
# FILENAME = rethresh.sh 

#SBATCH -A mcb130189
#SBATCH -J rethresh_cp2_NAC
#SBATCH -p shared
#SBATCH --time=0:40:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_NAC.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_NAC.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

# echo -e "\n Processing 202506221112_BICAN4x1-NAC-E05_VMSC31810 - region_UCI2424-NAC-E5 -- COUNTER 1 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI2424-NAC-E5 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221112_BICAN4x1-NAC-E05_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI2424-NAC-E5 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI2424-NAC-E5 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506221112_BICAN4x1-NAC-E05_VMSC31810 - region_UCI4723-NAC-E5 -- COUNTER 2 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI4723-NAC-E5 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221112_BICAN4x1-NAC-E05_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI4723-NAC-E5 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI4723-NAC-E5 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506221112_BICAN4x1-NAC-E05_VMSC31810 - region_UCI5224-NAC-E5 -- COUNTER 3 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI5224-NAC-E5 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221112_BICAN4x1-NAC-E05_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI5224-NAC-E5 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UCI5224-NAC-E5 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506221112_BICAN4x1-NAC-E05_VMSC31810 - region_UWA7648-NAC-E5 -- COUNTER 4 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UWA7648-NAC-E5 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221112_BICAN4x1-NAC-E05_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UWA7648-NAC-E5 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506221112_BICAN4x1-NAC-E05_VMSC31810 \
#     region_UWA7648-NAC-E5 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506301111_20250630M210BICANRen40_VMSC32010 - region_UCI2424Q04NAC -- COUNTER 5 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI2424Q04NAC \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506301111_20250630M210BICANRen40_VMSC32010/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI2424Q04NAC \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI2424Q04NAC \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506301111_20250630M210BICANRen40_VMSC32010 - region_UCI4723Q04NAC -- COUNTER 6 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI4723Q04NAC \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506301111_20250630M210BICANRen40_VMSC32010/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI4723Q04NAC \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI4723Q04NAC \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506301111_20250630M210BICANRen40_VMSC32010 - region_UCI5224Q04NAC -- COUNTER 7 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI5224Q04NAC \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506301111_20250630M210BICANRen40_VMSC32010/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI5224Q04NAC \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506301111_20250630M210BICANRen40_VMSC32010 \
#     region_UCI5224Q04NAC \
#     CPS \
#     --suffix filt \
#     --plot


echo -e "\n Processing 202506301111_20250630M210BICANRen40_VMSC32010 - region_UWA7648Q04NAC -- COUNTER 8 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506301111_20250630M210BICANRen40_VMSC32010 \
    region_UWA7648Q04NAC \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506301111_20250630M210BICANRen40_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506301111_20250630M210BICANRen40_VMSC32010 \
    region_UWA7648Q04NAC \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506301111_20250630M210BICANRen40_VMSC32010 \
    region_UWA7648Q04NAC \
    CPS \
    --suffix filt \
    --plot

