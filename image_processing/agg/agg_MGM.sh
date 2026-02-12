#!/bin/bash
# FILENAME = proseg.sh 

#SBATCH -A mcb130189
#SBATCH -J agg_exp_mgm
#SBATCH -p wholenode
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/proseg_mgm.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/proseg_mgm.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\nAggregating experiments for UCSD Samples\n"
experiment_list='202506271605_20250627M208BICANRen39_VMSC32010'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    proseg_fv38 \
    --suffix _filt \
    --lab_name ucsd \
    --project_name BICAN_BG_MGM

echo -e "\n DONE \n"

pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_MGM_ucsd_proseg_fv38_filt


# echo -e "\nAggregating experiments for SALK Samples\n"
# experiment_list='202506221112_BICAN-4x1-MGM1-E-03_VMSC31910'

# pixi run -e preprocessing \
#     python -m spida.P.cli combine-datasets \
#     ${experiment_list} \
#     proseg_fv38 \
#     --suffix _filt \
#     --lab_name salk \
#     --project_name BICAN_BG_MGM


# pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_MGM_salk_proseg_fv38_filt

# echo -e "\n DONE \n"
