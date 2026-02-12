#!/bin/bash
# FILENAME = rethresh.sh 

#SBATCH -A mcb130189
#SBATCH -J rethresh_cp2_CAH
#SBATCH -p shared
#SBATCH --time=2:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_CAH.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_CAH.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\n Processing 202506151211_BICAN4x1-CAH-E03_VMSC31810 - region_UCI2424-CAH-E3 -- COUNTER 1 / 8 \n"

# Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI2424-CAH-E3 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506151211_BICAN4x1-CAH-E03_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI2424-CAH-E3 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI2424-CAH-E3 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506151211_BICAN4x1-CAH-E03_VMSC31810 - region_UCI4723-CAH-E3 -- COUNTER 2 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI4723-CAH-E3 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506151211_BICAN4x1-CAH-E03_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI4723-CAH-E3 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI4723-CAH-E3 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506151211_BICAN4x1-CAH-E03_VMSC31810 - region_UCI5224-CAH-E3 -- COUNTER 3 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI5224-CAH-E3 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506151211_BICAN4x1-CAH-E03_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI5224-CAH-E3 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UCI5224-CAH-E3 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506151211_BICAN4x1-CAH-E03_VMSC31810 - region_UWA7648-CAH-E3 -- COUNTER 4 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UWA7648-CAH-E3 \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506151211_BICAN4x1-CAH-E03_VMSC31810/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UWA7648-CAH-E3 \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# # SETUP ADATA 
# pixi run -e preprocessing \
#     python -m spida.P setup_adata_region \
#     202506151211_BICAN4x1-CAH-E03_VMSC31810 \
#     region_UWA7648-CAH-E3 \
#     CPS \
#     --suffix filt \
#     --plot


# echo -e "\n Processing 202506191430_20250619M204BICANRen35_VMSC32010 - region_UCI2424Q06CaH -- COUNTER 5 / 8 \n"

# # Loading in the segmentation into the zarr store
# pixi run -e preprocessing \
#     python -m spida.S load_segmentation_region \
#     202506191430_20250619M204BICANRen35_VMSC32010 \
#     region_UCI2424Q06CaH \
#     /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506191430_20250619M204BICANRen35_VMSC32010/cellpose \
#     --type vpt \
#     --prefix_name CPS \
#     --plot

# # FILTERING 
# pixi run -e preprocessing \
#     python -m spida.P filter_cells_region \
#     202506191430_20250619M204BICANRen35_VMSC32010 \
#     region_UCI2424Q06CaH \
#     CPS \
#     --plot \
#     --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UCI2424Q06CaH \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202506191430_20250619M204BICANRen35_VMSC32010 - region_UCI4723Q06CaH -- COUNTER 6 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UCI4723Q06CaH \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506191430_20250619M204BICANRen35_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UCI4723Q06CaH \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UCI4723Q06CaH \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202506191430_20250619M204BICANRen35_VMSC32010 - region_UCI5224Q06CaH -- COUNTER 7 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UCI5224Q06CaH \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506191430_20250619M204BICANRen35_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UCI5224Q06CaH \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UCI5224Q06CaH \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202506191430_20250619M204BICANRen35_VMSC32010 - region_UWA7648Q06CaH -- COUNTER 8 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UWA7648Q06CaH \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506191430_20250619M204BICANRen35_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UWA7648Q06CaH \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506191430_20250619M204BICANRen35_VMSC32010 \
    region_UWA7648Q06CaH \
    CPS \
    --suffix filt \
    --plot

