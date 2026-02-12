#!/bin/bash
# FILENAME = calculate_cc_contacts.sh 

#SBATCH -A mcb130189
#SBATCH -J cc_contacts_r15
#SBATCH -p wholenode
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/cc_contacts_r15.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/cc_contacts_r15.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/calculate_cc_contacts.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/calculate_cc_contacts_r15.ipynb \
    -p r_test 15 \
    -p r_permute 200 \
    -p output_path /home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/cell_contacts_15um \
    -p path /home/x-aklein2/projects/aklein/BICAN/BG/data/BICAN_BG_CPS.h5ad \
    -k preprocessing

echo "Done Calculating CC Contacts"
