#!/bin/sh

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv activate python_package_template

pip install --upgrade setuptools pip wheel pip-tools

pip-compile "$@"
pip-sync requirements.txt
