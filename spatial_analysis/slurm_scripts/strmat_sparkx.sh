#!/bin/bash
# FILENAME = strmat_sparkx.sh 

#SBATCH -A mcb130189
#SBATCH -J strmat_sparkx
#SBATCH -p wholenode
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/str_mat_sparkx.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/str_mat_sparkx.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/spark_runner.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_sparkx_brs.ipynb\
    -p AD_PATH /home/x-aklein2/projects/aklein/BICAN/BG/data/BICAN_BG_CPS.h5ad \
    -p OUTDIR /home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/sparkx_brs \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/CPS/sparkx_brs \
    -p REP_KEY brain_region \
    -p CELLTYPE_KEY Subclass \
    -p AXIS MS_NORM \
    -p min_cells 50 \
    -p num_cores 4 \
    -k dist

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/spark_runner.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_sparkx_brg.ipynb\
    -p AD_PATH /home/x-aklein2/projects/aklein/BICAN/BG/data/BICAN_BG_CPS.h5ad \
    -p OUTDIR /home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/sparkx_brg \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/CPS/sparkx_brg \
    -p REP_KEY brain_region \
    -p CELLTYPE_KEY Group \
    -p AXIS MS_NORM \
    -p min_cells 50 \
    -p num_cores 4 \
    -k dist

# pixi run \
#     papermill \
#     /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/spark_runner.ipynb \
#     /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_sparkx_dsid.ipynb\
#     -p AD_PATH /home/x-aklein2/projects/aklein/BICAN/BG/data/BICAN_BG_CPS.h5ad \
#     -p OUTDIR /home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/sparkx_dsid \
#     -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/CPS/sparkx_dsid \
#     -p REP_KEY dataset_id \
#     -p CELLTYPE_KEY Subclass \
#     -p AXIS MS_NORM \
#     -p min_cells 50 \
#     -p num_cores 4 \
#     -k dist


# pixi run \
#     papermill \
#     /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/spark_runner.ipynb \
#     /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_sparkx_donor.ipynb\
#     -p AD_PATH /home/x-aklein2/projects/aklein/BICAN/BG/data/BICAN_BG_CPS.h5ad \
#     -p OUTDIR /home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/sparkx_donor \
#     -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/CPS/sparkx_donor \
#     -p REP_KEY donor \
#     -p CELLTYPE_KEY Subclass \
#     -p AXIS MS_NORM \
#     -p min_cells 50 \
#     -p num_cores 4 \
#     -k dist


echo "Done Calculating MS SparkX"
