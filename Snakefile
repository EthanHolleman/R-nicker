include: 'rules/download.smk'
include: 'rules/amplicon_fastas.smk'
include: 'rules/rlooper.smk'

import pandas as pd
from pathlib import Path

df = pd.read_csv('rawdata/footprinted_sites.bed', header=None, sep='\t')
fasta_names = [f'{df.loc[i][3]}::{df.loc[i][0]}:{df.loc[i][1]}-{df.loc[i][2]}' for i in range(len(df))]
rlooper_output_wigs = [
    'output/rlooper/{name}/{name}_bpprob.wig'.format(name=name) for name in fasta_names
]


rule all:
    input:
        'output/footprinted_fastas',
        rlooper_output_wigs