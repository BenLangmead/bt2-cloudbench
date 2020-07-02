#!/bin/bash

set -ex

BRANCH="${1}"

if [[ -z "${BRANCH}" ]] ; then
    BRANCH=master
fi

test -n "${THREADS}"

git clone --recursive https://github.com/BenLangmead/bowtie.git /work/bowtie
cd /work/bowtie
git checkout "${BRANCH}"
sed -i.bak 's/ [-]m64$//' Makefile

if [ "${ARCH}" = "aarch64" ] ; then
    make POPCNT_CAPABILITY=0 -j "${THREADS}" allall
else
    make -j "${THREADS}" allall
fi
