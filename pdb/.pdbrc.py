'''
This is used for extending the default behavior of PDB++.

For more info, see:

    https://github.com/pdbpp/pdbpp
'''


import pdb


if hasattr(pdb, 'DefaultConfig'):
    class Config(pdb.DefaultConfig):
        prompt = '(PDB++) '
