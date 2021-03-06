#!/bin/bash

set -ex

NUM=10000000

for fn in \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR194/ERR194147/ERR194147_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR194/ERR194147/ERR194147_2.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR069/SRR069520/SRR069520_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR069/SRR069520/SRR069520_2.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR394/001/SRR3947551/SRR3947551_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR394/001/SRR3947551/SRR3947551_2.fastq.gz
do
	bn=$(basename $fn)
	bn=$(echo $bn | sed 's/\.gz$//')
	curl ${fn} | gzip -dc | head -n ${NUM} > $bn
done
