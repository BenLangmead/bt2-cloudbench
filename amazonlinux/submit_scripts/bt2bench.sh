#!/bin/sh

set -ex

expt_name=bench-bt2
profile=jhu_ue2

instances=""
for typ in c5 c5d c5a c5ad c6g c6gd m5 m5d m6g m6gd m5a m5ad ; do
  for i in 2 4 8 ; do
    instances="${instances} ${typ}.${i}xlarge"
  done
done

for i in ${instances} ; do
    nm="${expt_name}.${i}"
    rm -rf ".${nm}"
    screen -S ${nm} -dm bash -c \
           "./vagrant_run.py ${profile} ${expt_name} ${i} .${nm} && cd .${nm} && ./run.sh"
done
