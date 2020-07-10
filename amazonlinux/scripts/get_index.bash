#!/bin/bash

set -ex

INDEX="${1}"

mkdir -p /work/indexes

for i in 1 2 3 4 rev.1 rev.2 ; do
    aws s3 cp --quiet "s3://bt2-bench/indexes/${INDEX}.${i}.bt2" "/work/indexes/idx.${i}.bt2"
done

ls /work/indexes
