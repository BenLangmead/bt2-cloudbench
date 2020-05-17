FROM debian:buster

RUN apt-get update -y && apt-get install -y bowtie2 wget curl
RUN mkdir /bench
COPY bench.sh /bench/bench.sh
COPY reads.py /bench/reads.py
RUN chmod a+x /bench/bench.sh

WORKDIR /bench
CMD /bench/bench.sh
