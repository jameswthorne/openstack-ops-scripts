#!/bin/bash

command -v openstack >/dev/null 2>&1 || { echo >&2 "openstack command not found. Aborting."; exit 1; }

OPENRC="/root/openrc"

# Source in an OpenStack admin user's openrc file
if [ -r "$OPENRC" ]; then
    . $OPENRC
else
    echo "$OPENRC not found. Aborting."
    exit 1
fi

# Gather the list of all Compute Nodes and iterate through each
for HYPERVISOR in $(nova hypervisor-list | grep -v '^+-' | grep -v '^| ID' | awk '{print $4}')
do
    echo ${HYPERVISOR}

    # For each Compute Node, gather the list of all OpenStack Instances on that
    # Compute Node and iterate through each to obtain each OpenStack Instances'
    # name and ID
    for INSTANCEID in $(nova hypervisor-servers ${HYPERVISOR} | grep -v '^+-' | grep -v '^| ID' | awk '{print $2}')
    do
        HOSTNAME=$(nova show ${INSTANCEID} | grep -v '^+-' | grep -v '^| ID' | grep 'OS-EXT-SRV-ATTR:hostname' | awk '{print $4}')

        echo "|-${HOSTNAME} (${INSTANCEID})"
    done
    
    echo
done