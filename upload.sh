#!/bin/bash

# Usage: Make sure setup.py is updated with the latest version number

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

GIT_CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
GIT_DEFAULT_BRANCH=`git remote show origin | grep "HEAD branch" | sed 's/.*: //'`
VERSION_REGEX="^v[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+$"

GIT_VERSION_TAG="$(python -c 'import importlib.metadata; print(importlib.metadata.version("python_package_template"))')"
if [ ! $GIT_VERSION_TAG ]; then
    echo "No action taken. Install python_package_template package."
    exit 1
fi
GIT_VERSION_TAG="v$GIT_VERSION_TAG"

if [ $GIT_CURRENT_BRANCH != $GIT_DEFAULT_BRANCH ]; then
    echo "No action taken. Switch to default branch."
    exit 1
fi

if [ git rev-parse $GIT_VERSION_TAG >/dev/null 2>&1 ]; then
    echo "No action taken. Tag exists."
    exit 1
fi

if [[ ! $GIT_VERSION_TAG =~ $VERSION_REGEX ]]; then
    echo "No action taken. Invalid version number: $GIT_VERSION_TAG"
    exit
fi

git tag $GIT_VERSION_TAG
git push origin $GIT_VERSION_TAG
