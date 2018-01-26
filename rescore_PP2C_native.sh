#!/bin/bash

#-s starting
#-native: reference for rmsd calc
# -l list file

PDB_NAME=$1

cd /home/achitturi/Desktop/$PDB_NAME-structures
ls -d -1 $PWD/*.pdb* > /home/achitturi/Downloads/rosetta_src_2017.08.59291_bundle/main/source/$PDB_NAME.list_of_pdbs.txt

cd /home/achitturi/Downloads/rosetta_src_2017.08.59291_bundle/main/source/

bin/score.linuxgccrelease -l $PDB_NAME.list_of_pdbs.txt -use_terminal_residues true -in:file:native /home/achitturi/Desktop/default.pdb -out:file:scorefile /home/achitturi/Desktop/$PDB_NAME-structures/$PDB_NAME.native.sc

#-in:Ntermini B -in:Ctermini B
