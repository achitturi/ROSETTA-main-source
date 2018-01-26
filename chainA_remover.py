#!usr/bin/python

import pyrosetta
pyrosetta.init()
from pyrosetta import *
import glob
import sys
import os

import Bio.PDB as bpdb

class ResSelect(bpdb.Select):
    def accept_residue(self, res):
        if res.parent.id == chain_id:
            return False
        else:
            return True

def main():
    str_path = '/home/achitturi/Desktop/' + sys.argv[1] + "-structures/"
    os.chdir(str_path)
    pdb_struct_list = sorted(glob.glob('./*.pdb'))
    os.mkdir("cropped_structures")
    count = 0
    for pdb_struct in pdb_struct_list:
        str1 = '/home/achitturi/Desktop/'
        str2 = pdb_struct[:-9]
        str3 = str2[2:] + "-structures/"
        str4 = pdb_struct[2:]
        pdb_path = str1+str3+str4
    
        s = bpdb.PDBParser().get_structure('temp',pdb_path)
        global chain_id
        chain_id = 'A'

        io = bpdb.PDBIO()
        io.set_structure(s)
        io.save(str_path + "cropped_structures/" + str("%03d" % count) + 'cropped.pdb', ResSelect())
        count = count + 1

if __name__ == "__main__":
    main()
