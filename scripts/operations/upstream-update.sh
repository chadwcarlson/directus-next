#!/usr/bin/env bash

set -e

git remote add upstream $UPSTREAM_REMOTE
git fetch --all
git merge upstream/master