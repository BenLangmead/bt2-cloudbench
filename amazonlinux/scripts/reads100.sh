#!/bin/bash

set -ex

SEED=765

cd /work

chmod a+x reads.py
./reads.py --prefix=mix100 \
	--temp-dir=mix100_temp \
	--reads-per-accession 2000000 \
	--seed ${SEED} \
	--trim-to 100
