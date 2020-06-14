#!/bin/bash

set -ex

cd /work

URL_BASE="https://ftp.ncbi.nlm.nih.gov/genomes/all"
ASM="${1}"
ACC="${2}"
LONG="${ACC}_${ASM}"

cd /work \
    && FA="${LONG}_genomic.fna" \
    && DIR1="${ACC:0:3}" \
    && DIR2="${ACC:4:3}" \
    && DIR3="${ACC:7:3}" \
    && DIR4="${ACC:10:3}" \
    && wget --quiet "${URL_BASE}/${DIR1}/${DIR2}/${DIR3}/${DIR4}/${LONG}/${FA}.gz" \
    && gunzip "${FA}.gz" \
    && echo "Sequences:" \
    && grep '^>' ${FA} \
    && /work/bowtie2/bowtie2-build-s --threads 16 "${FA}" "${ASM}" \
    && rm -f "${FA}" \
    && mkdir -p "${ASM}" \
    && mv ${ASM}*.bt2 "${ASM}" \
    && for i in 1.bt2 2.bt2 3.bt2 4.bt2 rev.1.bt2 rev.2.bt2 ; do \
           aws s3 cp --quiet "${ASM}/${ASM}.$i" s3://${BUCKET}/indexes/ ; \
       done \
    && zip "${ASM}.zip" -r "${ASM}" \
    && rm -rf "${ASM}" \
    && aws s3 cp --quiet "${ASM}.zip" s3://${BUCKET}/indexes/ \
    && rm -f "${ASM}.zip"
