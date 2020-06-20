#!/bin/bash

set -ex

cd /work

NUM=10000000

for fn in \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR118/ERR118325/ERR118325_1.fastq.gz \
	ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR118/ERR118325/ERR118325_2.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR118/ERR118328/ERR118328_1.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR118/ERR118328/ERR118328_2.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134264/ERR134264_1.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134264/ERR134264_2.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134266/ERR134266_1.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134266/ERR134266_2.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134268/ERR134268_1.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134268/ERR134268_2.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134270/ERR134270_1.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134270/ERR134270_2.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134277/ERR134277_1.fastq.gz \
  ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR134/ERR134277/ERR134277_2.fastq.gz
do
	bn=$(basename $fn)
	bn=${bn/%.gz/}
	curl ${fn} 2>/dev/null | gzip -dc | head -n ${NUM} > "${bn}"
done
