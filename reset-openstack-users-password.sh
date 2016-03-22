#!/bin/bash

# Make sure needed commands exist
command -v openstack >/dev/null 2>&1 || { echo >&2 "openstack command not found. Aborting."; exit 1; }
command -v curl >/dev/null 2>&1 || { echo >&2 "curl command not found. Aborting."; exit 1; }
command -v tr >/dev/null 2>&1 || { echo >&2 "tr command not found. Aborting."; exit 1; }
command -v head >/dev/null 2>&1 || { echo >&2 "head command not found. Aborting."; exit 1; }

EMAILPATH="$1"
OPENRC="/root/openrc"

# Source in an OpenStack admin user's openrc file
if [ -r "$OPENRC" ]; then
    . $OPENRC
else
    echo "$OPENRC not found. Aborting."
    exit 1
fi

# Print script usage if not enough arguments
if [ "$#" -ne "1" ]; then
    echo "Usage: $0 <ABSOLUTE PATH TO EMAIL LIST>"
    echo
    exit 1
fi

while read i; do
    EMAIL=$i
    USERNAME=$(echo $i | cut -d'@' -f 1)
    PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)

    # Check if user exists
    if openstack user show $USERNAME > /dev/null 2>&1; then
        # If user exists, change password
        openstack user set --password $PASSWORD $USERNAME
        # POST the generated password to password sharing website
        PASSWORDLINK=$(curl -sS -X POST -d "$PASSWORD" -H "Content-Type:text/plain" https://passwd.thornelabs.net/api | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["web"]')

        echo "Username: $USERNAME"
        echo "Email: $EMAIL"
        echo "Password: $PASSWORDLINK"
        echo
    else
        echo "User doesn't exist"
    fi
done <$EMAILPATH