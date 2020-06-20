#!/bin/bash

set -ex

cd /work

NUM=10000000

# ERR3239335: AFR from 1000 Genomes
#

for fn in \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR194/ERR194147/ERR194147_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR194/ERR194147/ERR194147_2.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR069/SRR069520/SRR069520_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR069/SRR069520/SRR069520_2.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR394/001/SRR3947551/SRR3947551_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR394/001/SRR3947551/SRR3947551_2.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR323/005/ERR3239335/ERR3239335_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR323/005/ERR3239335/ERR3239335_2.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR176/003/SRR1766443/SRR1766443_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR176/003/SRR1766443/SRR1766443_2.fastq.gz
do
	bn=$(basename $fn)
	bn=${bn/%.gz/}
	curl ${fn} | gzip -dc | head -n ${NUM} > "${bn}"
done
