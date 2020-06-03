FROM fedora:32

RUN yum update -y && yum install -y bowtie bowtie2 which

CMD bowtie2 --version && ldd `which bowtie2-align-s`
