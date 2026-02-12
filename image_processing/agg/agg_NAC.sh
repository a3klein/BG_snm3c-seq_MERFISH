#!/bin/bash
# FILENAME = proseg.sh 

#SBATCH -A mcb130189
#SBATCH -J agg_exp_nac
#SBATCH -p wholenode
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/proseg_nac.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/proseg_nac.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\nAggregating experiments for UCSD Samples\n"
experiment_list='202506301111_20250630M210BICANRen40_VMSC32010'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    proseg_fv38 \
    --suffix _filt \
    --lab_name ucsd \
    --project_name BICAN_BG_NAC

echo -e "\n DONE \n"

pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_NAC_ucsd_proseg_fv38_filt


echo -e "\nAggregating experiments for SALK Samples\n"
experiment_list='202506221112_BICAN4x1-NAC-E05_VMSC31810'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    proseg_fv38 \
    --suffix _filt \
    --lab_name salk \
    --project_name BICAN_BG_NAC


pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_NAC_salk_proseg_fv38_filt

echo -e "\n DONE \n"
