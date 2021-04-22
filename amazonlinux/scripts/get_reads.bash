#!/bin/bash

set -ex

SPECIES="${1}"
READLEN=100

mkdir -p /work/reads

for i in 1 2 ; do
    aws s3 cp --quiet "s3://genome-idx/bt/reads/${SPECIES}/mix${READLEN}_${i}.fq" "/work/reads/mix${READLEN}_${i}.fq"
done

ls /work/reads
