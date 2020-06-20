#!/bin/bash

set -ex

if [ "${ARCH}" = "aarch64" ] ; then
    git clone --recursive https://github.com/BenLangmead/bowtie2.git /work/bowtie2 \
        && cd /work/bowtie2 \
        && git checkout v2.4.1 \
        && sed -i.bak 's/CXXFLAGS :=/CXXFLAGS +=/' Makefile \
        && sed -i.bak 's/CPPFLAGS :=/CPPFLAGS +=/' Makefile \
        && make POPCNT_CAPABILITY=0 bowtie2-align-s bowtie2-build-s
else
    git clone --recursive https://github.com/BenLangmead/bowtie2.git /work/bowtie2 \
        && cd /work/bowtie2 \
        && git checkout v2.4.1 \
        && make bowtie2-align-s bowtie2-build-s
fi
