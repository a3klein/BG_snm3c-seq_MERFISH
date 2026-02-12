#!/bin/bash
# FILENAME = proseg.sh 

#SBATCH -A mcb130189
#SBATCH -J agg_exp_gp
#SBATCH -p shared
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/CPS_gp.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/CPS_gp.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\nAggregating experiments for UCSD Samples\n"
experiment_list='202506221225_20250622M206BICANRen37_VMSC32010'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    CPS \
    --suffix filt \
    --lab_name ucsd \
    --project_name BICAN_BG_GP

echo -e "\n DONE \n"

pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_GP_ucsd_CPSfilt


echo -e "\nAggregating experiments for SALK Samples\n"
experiment_list='202506171319_BICAN-4x1-GP-E-05_VMSC31910'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    CPS \
    --suffix filt \
    --lab_name salk \
    --project_name BICAN_BG_GP

pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_GP_salk_CPSfilt

echo -e "\n DONE \n"
