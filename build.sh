#!/usr/bin/env bash

if [ -n "$(ls -A extensions  2>/dev/null)" ]; then
    mkdir extensions-temp && mv extensions/* extensions-tmp
fi        
if [ -n "$(ls -A uploads 2>/dev/null)" ]; then
    mkdir uploads-tmp && mv uploads/* uploads-tmp
fi
