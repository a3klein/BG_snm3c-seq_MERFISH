#!/bin/bash
# FILENAME: cellpose.sh

#SBATCH -A mcb130189-gpu
#SBATCH -J cellpose_Ren42_UCI5224
#SBATCH -p gpu
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=64
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren42/cellpose_Ren42_UCI5224.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren42/cellpose_Ren42_UCI5224.out
#SBATCH --export=ALL

# module purge
module load modtree/gpu

module list

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/anvil/projects/x-mcb130189/aklein/programs/gsl/lib
export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo "Running Cellpose SAM on Region UCI5224 of Experiment Ren42"

# running cellpose
pixi run -e cellpose \
    python -m spida.S run \
    cellpose \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI5224Q02CaT \
    --input_dir /anvil/scratch/x-aklein2/BICAN/202507071458_20250707M212BICANRen42_VMSC32010/out/region_UCI5224Q02CaT/images \
    --output_dir /anvil/projects/x-mcb130189/aklein/BICAN/data/segmented/202507071458_20250707M212BICANRen42_VMSC32010/cellpose \
    --kwargs \
    scale=4 \
    image_ext=.decon.tif \
    nuc_stain_name=DAPI \
    cyto_stain_name=PolyT \
    flow_threshold=0 \
    cellprob_threshold=-4 \
    tile_norm_blocksize=0


# Loading in the segmentation into the zarr store
pixi run -e preprocessing \
    python -m spida.S load_segmentation_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI5224Q02CaT \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202507071458_20250707M212BICANRen42_VMSC32010/cellpose \
    --type vpt \
    --prefix_name cellpose_SAM \
    --plot

# Loading in deconvoluted images
pixi run -e preprocessing python \
    -m spida.S load_decon_images \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI5224Q02CaT \
    --plot


# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI5224Q02CaT \
    cellpose_SAM \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202507071458_20250707M212BICANRen42_VMSC32010 \
    region_UCI5224Q02CaT \
    cellpose_SAM \
    --plot