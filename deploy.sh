#!/usr/bin/env bash

if [ -n "$(ls -A extensions-tmp 2>/dev/null)" ]; then
    cp -r extensions-tmp/* extensions
fi        
if [ -n "$(ls -A uploads-tmp 2>/dev/null)" ]; then
    cp -r uploads-tmp/* uploads
fi
