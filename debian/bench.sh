#!/bin/bash

if [ -z "${THREADS}" ] ; then
	THREADS=8
fi

set -ex

IDX_URL=ftp://ftp.ncbi.nlm.nih.gov/genomes/archive/old_genbank/Eukaryotes/vertebrates_mammals/Homo_sapiens/GRCh38/seqs_for_alignment_pipelines/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.bowtie_index.tar.gz
IDX_BASE=$(basename ${IDX_URL})
IDX_F1=$(echo ${IDX_BASE} | sed 's/[.]tar[.]gz$/.1.bt2/')

if [ ! -f ${IDX_F1} ] ; then
	echo "Downloading index..."
	curl -O -J -L ${IDX_URL} && tar zxf ${IDX_BASE} && rm -f ${IDX_BASE}
else
	echo "Index already present..."
fi

test -f ${IDX_F1}

grep ftp reads.py | awk '{print $2}' | sed "s/[',]//g" > .reads.txt
for i in $(cat .reads.txt) ; do
	READS_UNCOMP=$(basename $i | sed 's/[.]gz$//')
    if [ ! -f ${READS_UNCOMP} ] ; then
		echo "Downloading reads file ${READS_UNCOMP}..."
        curl -J -L $i | gzip -dc | head -n 10000000 | tail -n 1000000 > ${READS_UNCOMP}
	else
		echo "Reads file ${READS_UNCOMP} already present..."
    fi
	test -f ${READS_UNCOMP}
done

bowtie2 -u 100 -x /w/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.bowtie_index -1 /w/SRR069520_1.fastq -2 /w/SRR069520_2.fastq -S /dev/null -p ${THREADS} && time bowtie2 -x /w/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.bowtie_index -1 /w/SRR069520_1.fastq -2 /w/SRR069520_2.fastq -S /w/bench.sam -p ${THREADS}
