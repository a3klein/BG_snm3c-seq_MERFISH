#!/bin/bash
# FILENAME: whole_image_dw.sh

#SBATCH -A mcb130189-gpu
#SBATCH -J decon_CAT_UCI4723_P
#SBATCH -p gpu
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=4
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/CAT/decon_CAT_UCI4723_P.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/CAT/decon_CAT_UCI4723_P.out
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

echo "Running whole image deconvolution - PolyT - UCI4723 - CAT"

pixi run -e preprocessing \
    python -m spida.S decon_image \
    -i /anvil/scratch/x-aklein2/BICAN/202506291134_BICAN-4x1-CAT-E-03_VMSC31910/out/region_UCI-4723/images \
    --data_org_path /anvil/scratch/x-aklein2/BICAN/202506291134_BICAN-4x1-CAT-E-03_VMSC31910/raw/dataorganization.csv \
    -o /anvil/scratch/x-aklein2/BICAN/202506291134_BICAN-4x1-CAT-E-03_VMSC31910/analysis/region_UCI-4723/tile_images \
    --channels PolyT \
    -ts 2960 \
    --overlap 400 \
    --z_step 1.5 \
    --filter deconwolf \
    --filter_args tilesize=1500 \
    --gpu True \
    --plot_thr True
