#! /usr/bin/env python

import sys
import numpy as np
import itertools as it

import pyrosetta
pyrosetta.init()
from pyrosetta import *
import glob

from rosetta import *
from rosetta.core.scoring import *

def main():
  i = 0
  pose1 = Pose()
  pose2 = Pose()
  str_path = '/home/achitturi/Desktop/' + sys.argv[1] + "-structures/"
  os.chdir(str_path)
  pdb_struct_list = sorted(glob.glob('./*.pdb'))
  D = np.zeros((len(pdb_struct_list), len(pdb_struct_list)))
  filename_to_index_dict = {}
  mydict = {}
  proper_path_list = []
  for pdb_struct in pdb_struct_list: # pdb_struct = something like './PP2C_chlorophyll_default_XXXX.pdb'
    str1 = '/home/achitturi/Desktop/'
    str2 = pdb_struct[:-9]
    str3 = str2[2:] + "-structures/"
    str4 = pdb_struct[2:]
    pdb_path = str1+str3+str4
    proper_path_list.append(pdb_path)

    filename_to_index_dict[pdb_path] = i
    i += 1
  
  for a in range(0, len(pdb_struct_list)):
    pose = Pose()
    pose = pose_from_pdb(proper_path_list[a])
    mydict[pose] = proper_path_list[a]

  for x,y in it.combinations(mydict, 2):
    
    rmsd = rosetta.core.scoring.CA_rmsd(x,y)

    ind1 = filename_to_index_dict[mydict[x]]
    ind2 = filename_to_index_dict[mydict[y]]

    D[ind1, ind2] = rmsd
    D[ind2, ind1] = rmsd

  np.save("dist_mat_.npy",D)

main()
