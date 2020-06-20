#!/bin/bash

cd /work \
    && echo "Handling ${1} index" \
    && wget --quiet ftp://ftp.ccb.jhu.edu/pub/data/bowtie2_indexes/${1}.zip \
    && aws s3 cp --quiet ${1}.zip s3://${BUCKET}/indexes/ \
    && unzip ${1}.zip \
    && rm -f ${1}.zip \
    && for i in ${2}* ; do aws s3 cp --quiet $i s3://${BUCKET}/indexes/ ; done \
    && rm -f ${2}*
