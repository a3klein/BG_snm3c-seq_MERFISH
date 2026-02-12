#!/bin/bash
# FILENAME = rethresh.sh 

#SBATCH -A mcb130189
#SBATCH -J rethresh_cp2_CAB
#SBATCH -p shared
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_CAB.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_CAB.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\n Processing 202506171319_BICAN4x1-CAB-E01_VMSC31810 - region_UCI2424-CAB-E1 -- COUNTER 1 / 8 \n"

# Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI2424-CAB-E1 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN4x1-CAB-E01_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI2424-CAB-E1 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI2424-CAB-E1 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506171319_BICAN4x1-CAB-E01_VMSC31810 - region_UCI4723-CAB-E1 -- COUNTER 2 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI4723-CAB-E1 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN4x1-CAB-E01_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI4723-CAB-E1 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI4723-CAB-E1 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506171319_BICAN4x1-CAB-E01_VMSC31810 - region_UCI5224-CAB-E1 -- COUNTER 3 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI5224-CAB-E1 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN4x1-CAB-E01_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI5224-CAB-E1 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UCI5224-CAB-E1 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506171319_BICAN4x1-CAB-E01_VMSC31810 - region_UWA7648-CAB-E1 -- COUNTER 4 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UWA7648-CAB-E1 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506171319_BICAN4x1-CAB-E01_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UWA7648-CAB-E1 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506171319_BICAN4x1-CAB-E01_VMSC31810 \
#     region_UWA7648-CAB-E1 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506221351_20250622M207BICANRen38_VMSC32110 - region_UCI2424Q02CaB -- COUNTER 5 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI2424Q02CaB \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221351_20250622M207BICANRen38_VMSC32110/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI2424Q02CaB \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI2424Q02CaB \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506221351_20250622M207BICANRen38_VMSC32110 - region_UCI4723Q02CaB -- COUNTER 6 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI4723Q02CaB \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221351_20250622M207BICANRen38_VMSC32110/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI4723Q02CaB \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI4723Q02CaB \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506221351_20250622M207BICANRen38_VMSC32110 - region_UCI5224Q02CaB -- COUNTER 7 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI5224Q02CaB \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221351_20250622M207BICANRen38_VMSC32110/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI5224Q02CaB \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UCI5224Q02CaB \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506221351_20250622M207BICANRen38_VMSC32110 - region_UWA7648Q02CaB -- COUNTER 8 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UWA7648Q02CaB \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506221351_20250622M207BICANRen38_VMSC32110/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506221351_20250622M207BICANRen38_VMSC32110 \
#     region_UWA7648Q02CaB \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506221351_20250622M207BICANRen38_VMSC32110 \
    region_UWA7648Q02CaB \
    CPS \
    --suffix filt \
    --plot

