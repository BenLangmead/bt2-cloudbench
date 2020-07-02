#!/bin/bash

set -ex

BRANCH="${1}"

if [[ -z "${BRANCH}" ]] ; then
    BRANCH=master
fi

test -n "${THREADS}"

if [ "${ARCH}" = "aarch64" ] ; then
    git clone --recursive https://github.com/BenLangmead/bowtie.git /work/bowtie \
        && cd /work/bowtie \
        && git checkout "${BRANCH}" \
        && make POPCNT_CAPABILITY=0 -j "${THREADS}" allall
else
    git clone --recursive https://github.com/BenLangmead/bowtie.git /work/bowtie \
        && cd /work/bowtie \
        && git checkout "${BRANCH}" \
        && make -j "${THREADS}" allall
fi
