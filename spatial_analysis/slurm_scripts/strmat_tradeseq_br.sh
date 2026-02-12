#!/bin/bash
# FILENAME = strmat_tradeseq.sh 

#SBATCH -A mcb130189
#SBATCH -J strmat_tradeseq
#SBATCH -p wholenode
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/str_mat_tradeseq_br.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/str_mat_tradeseq_br.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/tradeseq_runner.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/str_mat_tradeseq_brs.ipynb\
    -p AD_PATH /home/x-aklein2/projects/aklein/BICAN/BG/data/BICAN_BG_CPS.h5ad \
    -p OUTDIR /home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/tradeseq_brs \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/CPS/tradeseq_brs \
    -p REP_KEY brain_region_corr \
    -p CELLTYPE_KEY Subclass \
    -p AXIS MS_NORM \
    -p min_cells 50 \
    -p N_WORKERS 8 \
    -p R_NUM_CORES 6 \
    -p NKNOTS 8 \
    -k dist

echo "Done Calculating MS TradeSeq"


# R_NUM_CORES -  cores per R tradeSeq call
# N_WORKERS - number of parallel tradeSeq calls