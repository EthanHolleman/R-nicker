# breakup a fasta file with multilple records into multiple files
# each named by their fasta header in a unix safe (remove spaces) manor
import argparse
from Bio import SeqIO
from pathlib import Path
import sys

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('fasta', metavar='F', help='Input fasta file to break up.')
    parser.add_argument('output_dir', metavar='O', help='Output directory to write single record files to.')
    return parser.parse_args()


def read_fasta(fasta_path):
    return SeqIO.parse(fasta_path, 'fasta')


def write_record_to_file(fasta_record, original_id, output_dir):
    record_id_safe = str(original_id).replace(' ', '_')
    output_fasta = Path(output_dir).joinpath(record_id_safe).with_suffix('.fa')
    SeqIO.write([fasta_record], output_fasta, 'fasta')
    return output_fasta


def modify_id_for_rlooper(fasta_record):
    template="range=FIXED:1-{} 5'pad=0 3'pad=0 strand=+ repeatMasking=none"
    end = len(fasta_record)
    name = fasta_record.id
    mod_name = name.split(':')[0]
    fasta_record.id = mod_name
    fasta_record.description = template.format(end)
    return fasta_record, name


def main():
    args = get_args()
    records = read_fasta(args.fasta)
    for each_record in records:
        each_record, original_id = modify_id_for_rlooper(each_record)
        write_record_to_file(each_record, original_id, args.output_dir)

if __name__ == '__main__':
    main()
    sys.exit()



