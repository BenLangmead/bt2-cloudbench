#!/bin/bash

set -ex

# $1 can be full_analysis_set or full_plus_hs38d1_analysis_set
# $2 can be GRCh38_noalt_as or GRCh38_noalt_decoy_as

URL_BASE="https://ftp.ncbi.nlm.nih.gov/genomes/all"
ACC="GCA_000001405.15"
ASM="GRCh38"
NEW_ASM="${2}"

LONG="${ACC}_${ASM}"
DIR1="${ACC:0:3}"
DIR2="${ACC:4:3}"
DIR3="${ACC:7:3}"
DIR4="${ACC:10:3}"

EXTRA="seqs_for_alignment_pipelines.ucsc_ids"
FA="${LONG}_${1}.fna"

wget --quiet "${URL_BASE}/${DIR1}/${DIR2}/${DIR3}/${DIR4}/${LONG}/${EXTRA}/${FA}.gz"
gunzip "${FA}.gz"
/work/bowtie2/bowtie2-build-s --threads 16 "${FA}" "${NEW_ASM}"
rm -f "${FA}"
mkdir -p "${NEW_ASM}"
mv ${NEW_ASM}*.bt2 "${NEW_ASM}"
for i in 1.bt2 2.bt2 3.bt2 4.bt2 rev.1.bt2 rev.2.bt2 ; do
    aws s3 cp --quiet "${NEW_ASM}/${NEW_ASM}.$i" "s3://${BUCKET}/indexes/"
done
zip "${NEW_ASM}.zip" -r "${NEW_ASM}"
rm -rf "${NEW_ASM}"
aws s3 cp --quiet "${NEW_ASM}.zip" "s3://${BUCKET}/indexes/"
rm -f "${NEW_ASM}.zip"
