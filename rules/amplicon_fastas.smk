# convert bed coordinates of footloop amplicons
# to fasta files

rule create_fasta:
    conda:
        '../envs/bedtools.yml'
    input:
        footprinted_sites='rawdata/footprinted_sites.bed',
        hg19='rawdata/hg19.fa'
    output:
        'output/footprinted_sites.fa'
    shell:'''
    bedtools getfasta -name -fi {input.hg19} -bed {input.footprinted_sites} > {output}
    '''


rule seperate_amplicon_sequences:
    conda:
        '../envs/python.yml'
    input:
        'output/footprinted_sites.fa'
    output:
        directory('output/footprinted_fastas')
    shell:'''
    mkdir -p {output}
    python scripts/breakup_fasta.py {input} {output}
    '''


