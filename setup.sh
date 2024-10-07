#!/bin/bash

PYTHON_VERSION=3.8.12
VENV_NAME=python-package-template


# install platform-specific packages
if [ $SKIP_DEPS -eq 0 ] ; then
    case $OSTYPE in
        linux*)
            if [ -f "/etc/debian_version" ]; then
                sudo apt-get update
                sudo apt-get install -y make build-essential libssl-dev \
                    zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget \
                    curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev \
                    libxmlsec1-dev libffi-dev liblzma-dev # python deps
                sudo apt-get install -y pipx
                pipx ensurepath
            else
                echo "Automatic dependency installation not supported for your " \
                     "flavor of Linux. Please install dependencies manually."
            fi
            ;;
        darwin*)
            if [ xcode-select -p > /dev/null 2>&1 ]; then
                echo "Installing XCode CLI. This may take a while...\n"
                xcode-select --install
            fi
            if [ which brew  > /dev/null 2>&1 ]; then
                echo "Installing Homebrew. This may take a while...\n"
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/" \
                                            "Homebrew/install/HEAD/install.sh)"
            fi
            brew install openssl readline sqlite3 xz zlib tcl-tk # python deps
            brew install pipx
            pipx ensurepath
            ;;
        *)
            echo "Automatic dependency installation not supported for your OS." \
                 "Please install dependencies manually."
            exit 1
            ;;
    esac
fi

# activate pyenv and install if not exists
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
if [ ! "$(pyenv --version)" ] ; then
    curl https://pyenv.run | bash
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

pyenv install $PYTHON_VERSION -s
pyenv virtualenv $PYTHON_VERSION $VENV_NAME
./update-deps.sh

pyenv activate $VENV_NAME

pre-commit install
