#!/bin/bash

set -ex

VER=v2.4.2

if [ "${ARCH}" = "aarch64" ] ; then
    git clone --recursive https://github.com/BenLangmead/bowtie2.git /work/bowtie2 \
        && cd /work/bowtie2 \
        && git checkout ${VER} \
        && git submodule init \
        && git submodule sync \
        && git submodule update \
        && sed -i.bak 's/CXXFLAGS :=/CXXFLAGS +=/' Makefile \
        && sed -i.bak 's/CPPFLAGS :=/CPPFLAGS +=/' Makefile \
        && make -j2 POPCNT_CAPABILITY=0 bowtie2-align-s bowtie2-build-s
else
    git clone --recursive https://github.com/BenLangmead/bowtie2.git /work/bowtie2 \
        && cd /work/bowtie2 \
        && git checkout ${VER} \
        && make -j2 bowtie2-align-s bowtie2-build-s
fi
