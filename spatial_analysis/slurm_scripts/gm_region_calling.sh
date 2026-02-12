#!/bin/bash
# FILENAME = wm_region_calling.sh 

#SBATCH -A mcb130189
#SBATCH -J gm_regions
#SBATCH -p wholenode
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH -o /home/x-aklein2/projects/aklein/BICAN/BG/logs/gm_regions.out
#SBATCH -e /home/x-aklein2/projects/aklein/BICAN/BG/logs/gm_regions.out
#SBATCH --export=ALL

export PATH="/home/x-aklein2/.pixi/bin:$PATH"
cd /anvil/projects/x-mcb130189/aklein/SPIDA

pixi run \
    papermill \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/templates/call_regions_wm.ipynb \
    /home/x-aklein2/projects/aklein/BICAN/BG/spatial_analysis/execute/call_regions_gm.ipynb \
    -p output_path /home/x-aklein2/projects/aklein/BICAN/BG/data/regions/gm_v1 \
    -p image_path /home/x-aklein2/projects/aklein/BICAN/BG/images/regions/gm_v1 \
    -p save_figs True \
    -r transfer_genes ["RBFOX3","GAD1","GAD2","DRD1","DRD2"] \
    -p hex_size 50 \
    -p hex_overlap 0 \
    -p gmm_cov_type "tied" \
    -p gene_agreement_thr 0.5 \
    -p dsc_comp_min_size 2 \
    -p gmm_ncomp 2 \
    -k preprocessing

echo "Done Calculating GM Regions"
