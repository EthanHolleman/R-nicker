

rule run_rlooper_on_sequence:
    input:
        fasta='output/footprinted_fastas/{fasta_name}.fa'
    params:
        output_prefix='output/rlooper/{fasta_name}/{fasta_name}',
        output_dir='output/rlooper/{fasta_name}',
        sigma=0.7
    output:
        'output/rlooper/{fasta_name}/{fasta_name}_bpprob.wig'
    shell:'''
    mkdir -p {params.output_dir}
    software/rlooper/bin/rlooper {input.fasta} {params.output_prefix} --sigma {params.sigma} --N auto
    '''