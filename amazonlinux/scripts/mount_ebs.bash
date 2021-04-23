#!/bin/bash

set -ex

if [ ! -d /work ] ; then
    if [[ -z "${VOLUME_NAME}" || "${VOLUME_NAME}" == "None" ]] ; then
        dv=$(lsblk --output NAME,SIZE | awk "\$2 == \"${VOLUME_GB}G\"" | cut -f1 -d' ')
    else
        dv="${VOLUME_NAME}"
    fi
    test -e "/dev/${dv}"
    mkfs -q -t ext4 "/dev/${dv}"
    mkdir /work
    mount "/dev/${dv}" /work/
    chmod a+w /work
fi
