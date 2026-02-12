#!/bin/bash
# FILENAME: cellpose.sh

#SBATCH -A mcb130189-gpu
#SBATCH -J cellpose_Ren36_UCI5224
#SBATCH -p gpu
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=64
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren36/cellpose_Ren36_UCI5224.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren36/cellpose_Ren36_UCI5224.out
#SBATCH --export=ALL

# module purge
module load modtree/gpu

module list

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/anvil/projects/x-mcb130189/aklein/programs/gsl/lib
export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo "Running Cellpose SAM on Region UCI5224 of Experiment Ren36"

# running cellpose
pixi run -e cellpose \
    python -m spida.S run \
    cellpose \
    202506191452_20250619M205BICANRen36_VMSC32110 \
    region_UCI5224Q02Pu \
    --input_dir /anvil/scratch/x-aklein2/BICAN/202506191452_20250619M205BICANRen36_VMSC32110/out/region_UCI5224Q02Pu/images \
    --output_dir /anvil/projects/x-mcb130189/aklein/BICAN/data/segmented/202506191452_20250619M205BICANRen36_VMSC32110/cellpose \
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
    202506191452_20250619M205BICANRen36_VMSC32110 \
    region_UCI5224Q02Pu \
    /home/x-aklein2/projects/aklein/BICAN/data/segmented/202506191452_20250619M205BICANRen36_VMSC32110/cellpose \
    --type vpt \
    --prefix_name cellpose_SAM \
    --plot

# Loading in deconvoluted images
pixi run -e preprocessing python \
    -m spida.S load_decon_images \
    202506191452_20250619M205BICANRen36_VMSC32110 \
    region_UCI5224Q02Pu \
    --plot


# FILTERING 
pixi run -e preprocessing \
    python -m spida.P filter_cells_region \
    202506191452_20250619M205BICANRen36_VMSC32110 \
    region_UCI5224Q02Pu \
    cellpose_SAM \
    --plot \
    --cutoffs_path /home/x-aklein2/projects/aklein/BICAN/data/filtering_cutoffs.json

# SETUP ADATA 
pixi run -e preprocessing \
    python -m spida.P setup_adata_region \
    202506191452_20250619M205BICANRen36_VMSC32110 \
    region_UCI5224Q02Pu \
    cellpose_SAM \
    --plot