#!/bin/sh

PYTHON_VERSION=3.8.12
VENV_NAME=python-package-template

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv install $PYTHON_VERSION -s
pyenv virtualenv $PYTHON_VERSION $VENV_NAME
./update-deps.sh

pyenv activate $VENV_NAME

# TODO
# install pipx
# https://pipx.pypa.io/latest/installation/
# brew install pipx # mac
pipx install copier
pre-commit install
