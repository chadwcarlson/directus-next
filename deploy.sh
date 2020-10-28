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

    # Alias the CLI
    # alias directus='node node_modules/directus/dist/cli'

    # Install the database
    # directus database install
    node node_modules/directus/dist/cli database install

    # Create the admin user role
    # ROLE_UUID=$(directus roles create --name admin --admin)
    ROLE_UUID=$(node node_modules/directus/dist/cli roles create --name admin --admin)

    # Pipe output of above command into this one, adding an initial admin user
    # directus users create --email admin@example.com --password password --role $ROLE_UUID
    node node_modules/directus/dist/cli users create --email admin@example.com --password password --role $ROLE_UUID

    # Create file that indicates first deploy and installation has been completed.
    touch var/platformsh.installed
fi;
