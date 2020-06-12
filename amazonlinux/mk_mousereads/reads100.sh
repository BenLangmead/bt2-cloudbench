#!/bin/bash

SEED=765

cd /work

python reads.py --prefix=mix100 \
	--temp-dir=mix100_temp \
	--reads-per-accession 2000000 \
	--seed ${SEED}
