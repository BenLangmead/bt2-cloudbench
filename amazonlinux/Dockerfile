FROM amazonlinux

RUN yum update -y && yum install -y make git wget curl tar zlib zlib-devel gcc gcc-c++ which

RUN mkdir -p /tbb \
    && cd /tbb \
    && wget -q https://github.com/oneapi-src/oneTBB/archive/2018_U5.tar.gz \
    && tar zxvf 2018_U5.tar.gz \
    && rm -f 2018_U5.tar.gz \
    && cd oneTBB-2018_U5 \
    && gmake -j8

ENV LIBRARY_PATH=$LIBRARY_PATH:/tbb/oneTBB-2018_U5/build/linux_intel64_gcc_cc7_libc2.26_kernel4.19.76_release
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/tbb/oneTBB-2018_U5/build/linux_intel64_gcc_cc7_libc2.26_kernel4.19.76_release
ENV CPATH=$CPATH:/tbb/oneTBB-2018_U5/include

RUN git clone --recursive https://github.com/BenLangmead/bowtie2.git /bowtie2 \
    && cd /bowtie2 \
    && git checkout v2.4.1 \
    && make bowtie2-align-s

COPY bench.sh /bench/bench.sh
COPY reads.py /bench/reads.py
RUN chmod a+x /bench/bench.sh

WORKDIR /bench
CMD /bench/bench.sh
