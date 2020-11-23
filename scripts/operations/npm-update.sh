#!/usr/bin/env bash

set -e

npm install
npm outdated --json true > package-diff.json

npm update

git add package.json package-lock.json package-diff.json

STAGED_UPDATES=$(git diff --cached)
if [${STAGED_UPDATES} -gt 0]; then
    git commit -m "Update npm dependencies and commit the diff to package-diff.json."    
else
    echo "No staged commits."
end