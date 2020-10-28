#!/usr/bin/env bash

if [ -n "$(ls -A extensions-tmp)" ]; then
    cp -r extensions-tmp/* extensions
fi        
if [ -n "$(ls -A uploads-tmp)" ]; then
    cp -r uploads-tmp/* uploads
fi
