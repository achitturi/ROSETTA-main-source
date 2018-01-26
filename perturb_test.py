from pymol import cmd, stored

#Set phi and psi angles

def set_phipsi(selection, phi=None, psi=None):
    for model, index in cmd.index('byca (' + selection + ')'):      # 'byca' limits selection to one atom per residue
	atsele = [
	    'first ((%s`%d) extend 2 and name C)' % (model, index), # prev C
	    'first ((%s`%d) extend 1 and name N)' % (model, index), # this N
	    '(%s`%d)' % (model, index),                             # this CA
	    'last ((%s`%d) extend 1 and name C)' % (model, index),  # this C
	    'last ((%s`%d) extend 2 and name N)' % (model, index),  # next N
	]
	try:
	    if phi is not None:
			cmd.set_dihedral(atsele[0], atsele[1], atsele[2], atsele[3], phi) #sets value for all phi in selection
	    if psi is not None:
			cmd.set_dihedral(atsele[1], atsele[2], atsele[3], atsele[4], psi) #sets value for all psi
	except:
	    print ' Error: cmd.set_dihedral failed'

def set_phi(selection, phi):
    set_phipsi(selection, phi=phi) #executable in Pymol

def set_psi(selection, psi):
    set_phipsi(selection, psi=psi) #executable

cmd.extend('set_phipsi', set_phipsi)
cmd.extend('set_phi', set_phi)
cmd.extend('set_psi', set_psi)

#Notes:
#Can only change to one phi, one psi calue for all angles in peptide. 
#Need to add more (phi1, psi1, etc.) so every one can be changed individually.
#
#Need to add phi/psi onto existing values! Must use get_phi, get_psi methods
#somehow.
