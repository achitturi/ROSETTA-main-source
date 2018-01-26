#!/bin/bash

clear

cd ~/Downloads/rosetta_src_2017.08.59291_bundle/main/source

PDB_NAME=$1
NSTRUCT=$2

if [ $# -eq 0 ] || [ -z "$1" ] || [ -z "$2" ] || [ ${PDB_NAME: -4} == ".pdb" ]; then
    echo "ERROR: No (or wrong) arguments provided"
    echo " "
    echo "arg1 = name of PDB file on Desktop (omit file extension!)"
    echo "arg2 = number of output structures"

    exit 1
else
bin/FlexPepDocking.linuxgccrelease -s /home/achitturi/Desktop/$PDB_NAME.pdb \
-overwrite \
-out:file:silent $PDB_NAME.silent \
-pep_refine -ex1 -ex2aro \
-nstruct $NSTRUCT \
-ignore_zero_occupancy false -auto_setup_metals -ignore_unrecognized_res \
-use_terminal_residues true && \
bin/extract_pdbs.linuxgccrelease -in:file:silent $PDB_NAME.silent \
-use_terminal_residues true && \
grep SCORE $PDB_NAME.silent > $PDB_NAME.scorelines && \
mkdir /home/achitturi/Desktop/$PDB_NAME-structures && mv $PDB_NAME* /home/achitturi/Desktop/$PDB_NAME-structures/ && \
bash rescore_PP2C_native.sh "$PDB_NAME" && \
python sel_res_scores.py $PDB_NAME && \
bin/cluster.linuxgccrelease -in:file:silent /home/achitturi/Desktop/$PDB_NAME-structures/$PDB_NAME.silent \
-database /home/achitturi/Downloads/rosetta_src_2017.08.59291_bundle/main/database \
-sort_groups_by_energy -auto_setup_metals -ignore_unrecognized_res \
-in:file:fullatom -cluster:radius -1 -cluster:population_weight 0.0 \
-use_terminal_residues true \
-out:file:silent /home/achitturi/Desktop/$PDB_NAME-structures/$PDB_NAME.cluster.silent > /home/achitturi/Desktop/$PDB_NAME-structures/cluster.log && \
sort -n -k2 /home/achitturi/Desktop/$PDB_NAME-structures/$PDB_NAME.native.sc | awk '{print $2 "\t" $NF}' > /home/achitturi/Desktop/$PDB_NAME-structures/sorted_scores.txt && \
sort -n -k2 /home/achitturi/Desktop/$PDB_NAME-structures/revised_scores.txt | awk '{print $1 "\t" $2}' > /home/achitturi/Desktop/$PDB_NAME-structures/sorted_revised_scores.txt && \
python chainA_remover.py $PDB_NAME && \
bin/cluster.linuxgccrelease -database /home/achitturi/Downloads/rosetta_src_2017.08.59291_bundle/main/database \
-in:file:s /home/achitturi/Desktop/$PDB_NAME-structures/cropped_structures/*.pdb \
-in:file:fullatom -use_terminal_residues true \
-cluster:radius -1 -cluster:sort_groups_by_energy > /home/achitturi/Desktop/$PDB_NAME-structures/peptide_cluster.log && \
bin/score.linuxgccrelease -database /home/achitturi/Downloads/rosetta_src_2017.08.59291_bundle/main/database \
-in:file:s /home/achitturi/Desktop/$PDB_NAME-structures/cropped_structures/*.pdb \
-use_terminal_residues true -in:file:native /home/achitturi/Desktop/cropped.pdb \
-out:file:scorefile /home/achitturi/Desktop/$PDB_NAME-structures/peptide_scorefile.sc && \
python dist_matrix.py $PDB_NAME
R CMD BATCH -$PDB_NAME plots_stats.R
fi

#-in:Ntermini B -in:Ctermini B \
#===========================================================================================================================
#Following steps:

# > sort -n -k2 /home/achitturi/Desktop/$PDB_NAME-structures/$PDB_NAME.native.sc | awk '{print $2 "\t" $NF}' > /home/achitturi/Desktop/$PDB_NAME-structures/sorted_scores.txt <-- use to sort scores from scorefile, find lowest-scoring structure overall! Do same w/ RS

# > python chainA_remover.py $PDB_NAME <-- generates peptides as separate PDB files

# | Move peptides into "cropped structures" directory

# > bin/cluster.linuxgccrelease -database /home/achitturi/Downloads/rosetta_src_2017.08.59291_bundle/main/database -in:file:s /home/achitturi/Desktop/$PDB_NAME-structures/cropped_structures/*.pdb -in:file:fullatom -use_terminal_residues true -cluster:radius -1 -cluster:sort_groups_by_energy > /home/achitturi/Desktop/$PDB_NAME-structures/peptide_cluster.log

# > bin/score.linuxgccrelease -database /home/achitturi/Downloads/rosetta_src_2017.08.59291_bundle/main/database -in:file:s /home/achitturi/Desktop/$PDB_NAME-structures/cropped_structures/*.pdb -use_terminal_residues true -in:file:native /home/achitturi/Desktop/cropped.pdb -out:file:scorefile /home/achitturi/Desktop/$PDB_NAME-structures/peptide_scorefile.sc

# | use R to generate score vs. RMSD plots. Revised scores vs. allatom_rms, peptide scores vs. peptide RMSD
