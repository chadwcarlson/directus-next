#!/usr/bin/env bash

set -e

if [ -n "$(ls -A extensions-tmp 2>/dev/null)" ]; then
    cp -r extensions-tmp/* extensions
fi        
if [ -n "$(ls -A uploads-tmp 2>/dev/null)" ]; then
    cp -r uploads-tmp/* uploads
fi

# First deploy database installation
if [ ! -f var/platformsh.installed ]; then
    # Install the database
    node node_modules/directus/dist/cli database install

    # Create file that indicates first deploy and installation has been completed.
    touch var/platformsh.installed
fi;
