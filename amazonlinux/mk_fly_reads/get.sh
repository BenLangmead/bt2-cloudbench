#!/bin/bash

set -ex

cd /work

NUM=10000000

for fn in \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR203/008/SRR2039538/SRR2039538_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR203/008/SRR2039538/SRR2039538_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR204/002/SRR2040552/SRR2040552_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR204/002/SRR2040552/SRR2040552_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR201/001/SRR2015521/SRR2015521_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR201/001/SRR2015521/SRR2015521_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR201/007/SRR2012657/SRR2012657_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR201/007/SRR2012657/SRR2012657_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR200/003/SRR2006603/SRR2006603_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR200/003/SRR2006603/SRR2006603_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR200/003/SRR2000043/SRR2000043_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR200/003/SRR2000043/SRR2000043_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR169/005/SRR1696895/SRR1696895_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR169/005/SRR1696895/SRR1696895_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR169/008/SRR1696818/SRR1696818_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR169/008/SRR1696818/SRR1696818_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR169/007/SRR1696807/SRR1696807_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR169/007/SRR1696807/SRR1696807_2.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR168/002/SRR1688222/SRR1688222_1.fastq.gz \
    ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR168/002/SRR1688222/SRR1688222_2.fastq.gz
do
	bn=$(basename $fn)
	bn=${bn/%.gz/}
	curl ${fn} 2>/dev/null | gzip -dc | head -n ${NUM} > "${bn}"
done
