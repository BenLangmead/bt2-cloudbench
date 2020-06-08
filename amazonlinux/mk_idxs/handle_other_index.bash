#!/bin/bash

cd /work \
    && bn=$(basename ${1}) \
    && echo "Handling ${bn} index" \
    && wget --quiet ${1} \
    && aws s3 cp --quiet ${bn} s3://${BUCKET}/indexes/ \
    && if echo ${bn} | grep -q '[.]tar[.]gz$' ; then \
           tar zxvf ${bn} ; \
       else \
           unzip ${bn} ; \
       fi \
    && rm -f ${bn} \
    && for i in ${2}* ; do aws s3 cp --quiet $i s3://${BUCKET}/indexes/ ; done \
    && rm -f ${2}*
