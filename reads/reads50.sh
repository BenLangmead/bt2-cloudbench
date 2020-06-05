#!/bin/bash

SEED=765

python reads.py --trim-to 50 \
	--max-read-size 175 \
	--prefix=mix50 \
	--temp-dir=mix50_temp \
	--reads-per-accession 2000000 \
	--seed ${SEED}
