from pymol import cmd

def set_phipsi(selection, phi=None, psi=None):
	for model, index in cmd.index('byca (' + selection + ')'):
		angles = [
			'first ((%s`%d) extend 2 and name C)' % (model, index), # prev C
			'first ((%s`%d) extend 1 and name N)' % (model, index), # this N
			'(%s`%d)' % (model, index),                             # this CA
			'last ((%s`%d) extend 1 and name C)' % (model, index),  # this C
			'last ((%s`%d) extend 2 and name N)' % (model, index),  # next N
		]
		try:
			if phi is not None:
				cmd.set_dihedral(angles[0], angles[1], angles[2], angles[3], phi)
			if psi is not None:
				cmd.set_dihedral(angles[1], angles[2], angles[3], angles[4], psi)
		except:
			print 'Error: cmd.set_dihedral failed'

def set_phi(selection, phi):
	set_phipsi(selection, phi=phi)

def set_psi(selection, psi):
	set_phipsi(selection, psi=psi)

cmd.extend('set_phipsi', set_phipsi)
cmd.extend('set_phi', set_phi)
cmd.extend('set_psi', set_psi)

#1. Insert lone hydrogen atom near the manganese center
#2. Attach the peptide by the phosphate to that hydrogen atom.
#3. Remove the hydrogen atom. Read: https://pymolwiki.org/index.php/Modeling_and_Editing_Structures

