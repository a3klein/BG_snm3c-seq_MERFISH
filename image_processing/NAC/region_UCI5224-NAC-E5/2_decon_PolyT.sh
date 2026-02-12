#!/bin/bash
# FILENAME: whole_image_dw.sh

#SBATCH -A mcb130189-gpu
#SBATCH -J decon_NAC_region_UCI5224-NAC-E5_P
#SBATCH -p gpu
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=4
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/NAC/decon_NAC_region_UCI5224-NAC-E5_P.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/NAC/decon_NAC_region_UCI5224-NAC-E5_P.out
#SBATCH --export=ALL

# module purge
module load modtree/gpu

module load gsl
module load libtiff
module load libpng
module load fftw

module list

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/anvil/projects/x-mcb130189/aklein/programs/gsl/lib
export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo "Running whole image deconvolution - PolyT - region_UCI5224-NAC-E5 - NAC"

pixi run -e preprocessing \
    python -m spida.S decon_image \
    -i /anvil/scratch/x-aklein2/BICAN/202506221112_BICAN4x1-NAC-E05_VMSC31810/out/region_UCI5224-NAC-E5/images \
    --data_org_path /anvil/scratch/x-aklein2/BICAN/202506221112_BICAN4x1-NAC-E05_VMSC31810/raw/dataorganization.csv \
    -o /anvil/scratch/x-aklein2/BICAN/202506221112_BICAN4x1-NAC-E05_VMSC31810/analysis/region_UCI5224-NAC-E5/tile_images \
    --channels PolyT \
    -ts 2960 \
    --overlap 400 \
    --z_step 1.5 \
    --filter deconwolf \
    --filter_args tilesize=1500 \
    --gpu True \
    --plot_thr True
