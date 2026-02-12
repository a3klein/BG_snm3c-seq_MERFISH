#!/bin/bash
# FILENAME = proseg.sh 

#SBATCH -A mcb130189
#SBATCH -J agg_exp_sth
#SBATCH -p shared
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/CPS_sth.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/CPS_sth.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\nAggregating experiments for UCSD Samples\n"
experiment_list='202507041709_20250704M211BICANRen41_VMSC32010'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    CPS \
    --suffix filt \
    --lab_name ucsd \
    --project_name BICAN_BG_STH

echo -e "\n DONE \n"

pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_STH_ucsd_CPSfilt


echo -e "\nAggregating experiments for SALK Samples\n"
experiment_list='202506291135_BICAN-4x1-SUBTH-E-05_VMSC31810'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    CPS \
    --suffix filt \
    --lab_name salk \
    --project_name BICAN_BG_STH


pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_STH_salk_CPSfilt

echo -e "\n DONE \n"
