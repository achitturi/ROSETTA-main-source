#!usr/bin/python

import pyrosetta
pyrosetta.init()
from pyrosetta import *
import glob
import sys
import os

def main():
  pose = Pose()
  str_path = '/home/achitturi/Desktop/' + sys.argv[1] + "-structures/"
  os.chdir(str_path)
  pdb_struct_list = sorted(glob.glob('./*.pdb'))
  for pdb_struct in pdb_struct_list: # pdb_struct = something like './PP2C_chlorophyll_default_XXXX.pdb'
    str1 = '/home/achitturi/Desktop/'
    str2 = pdb_struct[:-9]
    str3 = str2[2:] + "-structures/"
    str4 = pdb_struct[2:]
    pdb_path = str1+str3+str4

    scorefxn = get_fa_scorefxn()
    pose = Pose()
    pose = pose_from_pdb(pdb_path)
    print scorefxn(pose)
    scorefxn.show(pose)

    A_res_list = [69,73,93,94,95,96,162,180,201,222,223,224,225,228,229,230,231,232,238,240,241,296,297,300,339,340,401,402]
    B_res_list = [401,402,403,404,405]
    score = 0
    for i in A_res_list:
      score = score + pose.energies().residue_total_energy(int(pose.pdb_info().pdb2pose('A',i)))
    for j in B_res_list:
      score = score + pose.energies().residue_total_energy(int(pose.pdb_info().pdb2pose('B',j)))
    with open('revised_scores.txt','a') as scores_file:
      scores_file.write(str4 + "    " + str(score) + "\n")

if __name__ == "__main__":
    main()
