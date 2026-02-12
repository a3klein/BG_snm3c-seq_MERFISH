#!/bin/bash
# FILENAME = calculate_cc_contacts.sh 

#SBATCH -A mcb130189
#SBATCH -J ms_enrichment
#SBATCH -p shared
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/ms_enrichment.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/ms_enrichment.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/regional_ms_composition.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/regional_ms_composition2.ipynb \
    -p ad_path /home/x-aklein2/projects/aklein/BICAN/BG/data/BICAN_BG_CPS.h5ad \
    -p geom_store_path /home/x-aklein2/projects/aklein/BICAN/BG/data/regions/region_geometries_cps.parquet \
    -p N_permute 1000 \
    -p output_path /home/x-aklein2/projects/aklein/BICAN/BG/data/CPS/ms_enrichment \
    -k preprocessing

echo "Done Calculating MS Enrichment"


# -p output_path /home/x-aklein2/projects/aklein/BICAN/BG/data/PF/cell_contacts_30um \