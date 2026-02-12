#!/bin/bash
# FILENAME: whole_image_dw.sh

#SBATCH -A mcb130189-gpu
#SBATCH -J decon_Ren35_UCI5224_D
#SBATCH -p gpu
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=4
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren35/decon_Ren35_UCI5224_D.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/Ren35/decon_Ren35_UCI5224_D.out
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

echo "Running whole image deconvolution - DAPI - UCI5224 - Ren35"

pixi run -e preprocessing \
    python -m spida.S decon_image \
    -i /anvil/scratch/x-aklein2/BICAN/202506191430_20250619M204BICANRen35_VMSC32010/out/region_UCI5224Q06CaH/images \
    --data_org_path /anvil/scratch/x-aklein2/BICAN/202506191430_20250619M204BICANRen35_VMSC32010/raw/dataorganization.csv \
    -o /anvil/scratch/x-aklein2/BICAN/202506191430_20250619M204BICANRen35_VMSC32010/analysis/region_UCI5224Q06CaH/tile_images \
    --channels DAPI \
    -ts 2960 \
    --overlap 400 \
    --z_step 1.5 \
    --filter deconwolf \
    --filter_args tilesize=1500 \
    --gpu True \
    --plot_thr True
