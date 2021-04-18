
#!/bin/bash -l

mkdir -p Logs
snakemake -j 100 -s Snakefile --cluster-config cluster.yml \
--cluster "sbatch -p {cluster.partition} -t {cluster.time} -N {cluster.nodes} \
-n {cluster.cpus} --mem {cluster.mem} -J {cluster.name} -o {cluster.output} \
-e {cluster.output} --mail-type ALL --mail-user {cluster.email}" \
--conda-frontend=mamba \
--latency-wait 60 --verbose --use-conda --rerun-incomplete