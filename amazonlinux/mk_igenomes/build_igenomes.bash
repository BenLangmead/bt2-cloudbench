#!/bin/bash

set -ex

cd /work

URL_BASE="http://igenomes.illumina.com.s3-website-us-east-1.amazonaws.com"
SPECIES="${1}"
REPO="${2}"
ASM="${3}"
BN="${SPECIES}_${REPO}_${ASM}"
BN_TGZ="${BN}.tar.gz"
URL="${URL_BASE}/${SPECIES}/${REPO}/${ASM}/${BN_TGZ}"

wget "${URL}"
tar zxvf "${BN_TGZ}"
rm -f "${BN_TGZ}"

mkdir "${ASM}"

for i in 1.bt2 2.bt2 3.bt2 4.bt2 rev.1.bt2 rev.2.bt2 ; do
  mv "${SPECIES}/${REPO}/${ASM}/Sequence/Bowtie2Index/genome.${i}" "${ASM}/${ASM}.${i}"
done
rm -rf "${SPECIES}"

for i in 1.bt2 2.bt2 3.bt2 4.bt2 rev.1.bt2 rev.2.bt2 ; do
  aws s3 cp --quiet "${ASM}/${ASM}.$i" s3://${BUCKET}/indexes/
done

zip "${ASM}.zip" -r "${ASM}"
rm -rf "${ASM}"

aws s3 cp --quiet "${ASM}.zip" s3://${BUCKET}/indexes/
rm -f "${ASM}.zip"

