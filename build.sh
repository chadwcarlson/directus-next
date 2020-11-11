#!/usr/bin/env bash

set -e 

moveDevelopmentDirs() {
    # Array of directories that need 
    #   1. Runtime write access for api development.
    #   2. To allow committed files from local development.
    # 
    # NOTE: If updating, make sure to update the matching 
    #   restoreDevelopmentDirs in deploy.sh.
    declare -a dirs=(
                "extensions" 
                "uploads" 
                )

    for dir in "${dirs[@]}"
    do
        if [ -n "$(ls -A "$dir"  2>/dev/null)" ]; then
            mkdir "$dir"-temp && mv "$dir"/* "$dir"-tmp
        fi     
    done
}

set -e

moveDevelopmentDirs