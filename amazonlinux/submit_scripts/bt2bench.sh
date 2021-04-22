#!/bin/sh

set -ex

expt_name=bench-bt2
profile=jhu_ue2

for i in m5.4xlarge m6g.4xlarge ; do
    nm="${expt_name}.${i}"
    rm -rf ".${nm}"
    screen -S ${nm} -dm bash -c \
           "./vagrant_run.py ${profile} ${expt_name} ${i} .${nm} && cd .${nm} && ./run.sh"
done
