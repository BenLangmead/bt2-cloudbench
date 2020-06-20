#!/bin/bash

set -ex

VER=2018_U5

mkdir -p /work/tbb \
    && cd /work/tbb \
    && wget -q https://github.com/oneapi-src/oneTBB/archive/${VER}.tar.gz \
    && tar zxvf ${VER}.tar.gz \
    && rm -f ${VER}.tar.gz \
    && cd oneTBB-${VER} \
    && gmake -j8 \
    && TBB_BASE=$(ls -d /work/tbb/oneTBB-${VER}/build/linux_${ARCH}_*release) \
    && TBB_INCLUDE=/work/tbb/oneTBB-${VER}/include \
    && echo "export LIBRARY_PATH=\"\${LIBRARY_PATH}:${TBB_BASE}\"" >> ~/.bashrc \
    && echo "export LD_LIBRARY_PATH=\"\${LD_LIBRARY_PATH}:${TBB_BASE}\"" >> ~/.bashrc \
    && echo "export CPATH=\"\${CPATH}:${TBB_INCLUDE}\"" >> ~/.bashrc
