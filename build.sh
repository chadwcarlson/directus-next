#!/usr/bin/env bash

if [ -n "$(ls -A extensions)" ]; then
    mkdir extensions-temp && mv extensions/* extensions-tmp
fi        
if [ -n "$(ls -A uploads)" ]; then
    mkdir uploads-tmp && mv uploads/* uploads-tmp
fi
