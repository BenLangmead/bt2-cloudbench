FROM amazonlinux

RUN yum update -y && yum install -y make git wget curl tar zlib zlib-devel gcc gcc-c++ which

RUN wget https://www.threadingbuildingblocks.org/sites/default/files/software_releases/source/tbb44_20160526oss_src_0.tgz && \
  tar zxvf tbb44*.tgz && \
  cd tbb44* && \
  cd src && \
  make && \
  cd .. && \
  mkdir -p /usr/include/serial && \
  cp -a include/serial/* /usr/include/serial/ && \
  mkdir -p /usr/include/tbb && \
  cp -a include/tbb/* /usr/include/tbb/ && \
  cp build/linux_intel64*/libtbb.so.2 /usr/lib64/ && \
  ln -s /usr/lib64/libtbb.so.2 /usr/lib64/libtbb.so

RUN git clone https://github.com/BenLangmead/bowtie2.git /tmp/bowtie2 \
        && cd /tmp/bowtie2 \
        && git checkout v2.4.1 \
        && make bowtie2-align-s \
        && mkdir -p /bench \
        && cp /tmp/bowtie2/bowtie2-align-s /tmp/bowtie2/bowtie2 /bench/bowtie2

COPY bench.sh /bench/bench.sh
COPY reads.py /bench/reads.py
RUN chmod a+x /bench/bench.sh

WORKDIR /bench
CMD /bench/bench.sh
