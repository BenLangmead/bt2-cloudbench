#!/bin/bash

set -ex

mkdir /work/sam

[[ -z "${THREADS}" ]] && echo "THREADS must be set" && exit 1

/work/bowtie2/bowtie2-align-s \
  -x /work/index/idx \
  -p "${THREADS}" \
  -t \
  -1 /work/reads/mix100_1.fq -2 /work/reads/mix100_2.fq \
  -S /work/sam/out.sam

