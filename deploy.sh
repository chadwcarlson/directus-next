#!/usr/bin/env bash

INITIAL_ADMIN_EMAIL=admin@example.com
INITIAL_ADMIN_PW=password

restoreDevelopmentDirs() {
    # Array of directories that need 
    #   1. Runtime write access for api development.
    #   2. To allow committed files from local development.
    # 
    # NOTE: If updating, make sure to update the matching 
    #   moveDevelopmentDirs in build.sh.
    if [ -n "$(ls -A extensions  2>/dev/null)" ]; then
        cp -r extensions-tmp/* extensions
    fi   
    if [ -n "$(ls -A uploads 2>/dev/null)" ]; then
        cp -r uploads-tmp/* uploads
    fi  
}

initializeDB() {
    # Installs the database and sets up the initial admin user. Only run on first deploy.
    if [ ! -f var/platformsh.installed ]; then
        # Install the database
        echo 'Installing the database...'
        node node_modules/directus/dist/cli database install

        # Create the admin user role
        echo 'Setting up the initial admin role...'
        ROLE_UUID=$(node node_modules/directus/dist/cli roles create --name admin --admin)

        # Pipe output of above command into this one, adding an initial admin user
        echo 'Creating the initial admin user...'
        node node_modules/directus/dist/cli users create --email admin@example.com --password password --role $ROLE_UUID

        # Create file that indicates first deploy and installation has been completed.
        touch var/platformsh.installed
    fi;
}

set -e

# restoreDevelopmentDirs
initializeDB
