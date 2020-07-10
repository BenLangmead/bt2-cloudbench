#!/bin/bash

set -ex

SPECIES="${1}"

mkdir -p /work/reads

for i in 1 2 ; do
    aws s3 cp --quiet "s3://bt2-bench/reads/${SPECIES}/mix100_${i}.fq" "/work/reads/mix100_${i}.fq"
done

ls /work/reads
