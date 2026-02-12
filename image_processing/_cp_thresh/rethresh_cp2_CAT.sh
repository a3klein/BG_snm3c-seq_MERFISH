#!/bin/bash
# FILENAME = rethresh.sh 

#SBATCH -A mcb130189
#SBATCH -J rethresh_cp2_CAT
#SBATCH -p shared
#SBATCH --time=2:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_CAT.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/rethresh_cp2_CAT.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\n Processing 202506291134_BICAN-4x1-CAT-E-03_VMSC31910 - region_UCI-2424 -- COUNTER 1 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-2424 \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506291134_BICAN-4x1-CAT-E-03_VMSC31910/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-2424 \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-2424 \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202506291134_BICAN-4x1-CAT-E-03_VMSC31910 - region_UCI-4723 -- COUNTER 2 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-4723 \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506291134_BICAN-4x1-CAT-E-03_VMSC31910/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-4723 \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-4723 \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202506291134_BICAN-4x1-CAT-E-03_VMSC31910 - region_UCI-5224 -- COUNTER 3 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-5224 \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506291134_BICAN-4x1-CAT-E-03_VMSC31910/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-5224 \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506291134_BICAN-4x1-CAT-E-03_VMSC31910 \
    region_UCI-5224 \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202507071458_20250707M212BICANRen42_VMSC32010 - region_UCI2424Q02CaT -- COUNTER 4 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI2424Q02CaT \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202507071458_20250707M212BICANRen42_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI2424Q02CaT \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI2424Q02CaT \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202507071458_20250707M212BICANRen42_VMSC32010 - region_UCI4723Q02CaT -- COUNTER 5 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI4723Q02CaT \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202507071458_20250707M212BICANRen42_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI4723Q02CaT \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI4723Q02CaT \
    CPS \
    --suffix filt \
    --plot


echo -e "\n Processing 202507071458_20250707M212BICANRen42_VMSC32010 - region_UCI5224Q02CaT -- COUNTER 6 / 8 \n"

# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI5224Q02CaT \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202507071458_20250707M212BICANRen42_VMSC32010/cellpose \
    --type vpt \
    --prefix_name CPS \
    --plot

# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI5224Q02CaT \
    CPS \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs_cp2.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI5224Q02CaT \
    CPS \
    --suffix filt \
    --plot

