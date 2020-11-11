#!/usr/bin/env bash

set -e 

moveDevelopmentDirs() {
    # Array of directories that need 
    #   1. Runtime write access for api development.
    #   2. To allow committed files from local development.
    # 
    # NOTE: If updating, make sure to update the matching 
    #   restoreDevelopmentDirs in deploy.sh.
    if [ -n "$(ls -A extensions  2>/dev/null)" ]; then
        mkdir extensions-temp && mv extensions/* extensions-tmp
    fi   
    if [ -n "$(ls -A uploads 2>/dev/null)" ]; then
        mkdir uploads-temp && mv uploads/* uploads-tmp
    fi   
}

set -e

moveDevelopmentDirs