#!/bin/bash
# FILENAME = proseg.sh 

#SBATCH -A mcb130189
#SBATCH -J agg_exp_cat
#SBATCH -p shared
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/CPS_cat.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/agg/CPS_cat.out
#SBATCH --export=ALL

module load modtree/cpu
module list

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

echo -e "\nAggregating experiments for UCSD Samples\n"

# experiment_list='202506191430_20250619M204BICANRen35_VMSC32010' #,'202506191452_20250619M205BICANRen36_VMSC32110','202506221225_20250622M206BICANRen37_VMSC32010','202506221351_20250622M207BICANRen38_VMSC32110','202506301111_20250630M210BICANRen40_VMSC32010','202507041709_20250704M211BICANRen41_VMSC32010','202507071458_20250707M212BICANRen42_VMSC32010'
experiment_list='202507071458_20250707M212BICANRen42_VMSC32010'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    CPS \
    --suffix filt \
    --lab_name ucsd \
    --project_name BICAN_BG_CAT

echo -e "\n DONE \n"

pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_CAT_ucsd_CPSfilt

echo -e "\nAggregating experiments for UCSD Samples\n"

# experiment_list='202506151211_BICAN-4x1-PU-01_VMSC31910','202506221112_BICAN4x1-NAC-E05_VMSC31810','202506221112_BICAN-4x1-MGM1-E-03_VMSC31910','202506171319_BICAN-4x1-GP-E-05_VMSC31910','202506151211_BICAN4x1-CAH-E03_VMSC31810','202506291134_BICAN-4x1-CAT-E-03_VMSC31910','202506171319_BICAN4x1-CAB-E01_VMSC31810','202506291135_BICAN-4x1-SUBTH-E-05_VMSC31810'
experiment_list='202506291134_BICAN-4x1-CAT-E-03_VMSC31910'

pixi run -e preprocessing \
    python -m spida.P.cli combine-datasets \
    ${experiment_list} \
    CPS \
    --suffix filt \
    --lab_name salk \
    --project_name BICAN_BG_CAT


pixi run -e preprocessing python -m spida.P.cli setup-dataset BICAN_BG_CAT_salk_CPSfilt

echo -e "\n DONE \n"
