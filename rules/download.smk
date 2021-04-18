rule get_rlooper:
    output:
        'software/rlooper/bin/rlooper'
    params:
        soft_dir='software'
    shell:'''
    rm -rf {params.soft_dir}
    mkdir -p {params.soft_dir}
    cd {params.soft_dir}
    rm -rf rlooper  # somehow its already there???
    git clone https://github.com/chedinlab/rlooper.git
    cd rlooper
    make all
    '''

rule download_hg19:
    output:
        'rawdata/hg19.fa'
    shell:'''
    mkdir -p rawdata
    cd rawdata
    wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/bigZips/hg19.fa.gz
    gzip -d hg19.fa.gz
    '''
