#!/bin/bash

set -e

if [ -n "${DRIVER_LOCATION}" ]
then
    echo "Installing rpm from ${DRIVER_LOCATION}"
    curl -o /tmp/package.rpm -k $DRIVER_LOCATION
else
    echo "No DRIVER_LOCATION specified. skipping..."
    exit 1
fi

modexist=$(lsmod |grep scini | wc -l)
if [ ${modexist} -gt 0 ]
then
    echo "kernel module scini already loaded. nothing to do"
else
    echo "installing rpm driver"
    zypper in -y --allow-unsigned-rpm EMC-ScaleIO-sdc-4.5-2000.135.sles15.4.x86_64.rpm /tmp/package.rpm
    /opt/emc/scaleio/sdc/bin/scini start
fi

tail -f /dev/null