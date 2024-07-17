# python-package-template
`python-package-template` is a [copier](https://github.com/copier-org/copier) template to create **and update** Python packages. Copier uses git to merge changes from the original template into your instance, so you can keep all of your Python packages up to date and consistent.

## Initial Setup

### Basic Usage

`pipx install copier`


### Developer

Dependencies:
- [pyenv](https://github.com/pyenv/pyenv)
- [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)

Installation is made simple with [pyenv-installer](https://github.com/pyenv/pyenv-installer).

Once you have installed pyenv, install the rest of `python-package-template`'s dependencies with the setup script:

```bash
./setup.sh
```

## Update Package Dependencies

Add new dependencies to `requirements.in` and then run:

```bash
./update-deps.sh
```

## Local Usage

TODO add `pipx install copier` or provide another install method than running the setup script

### Create a new template

`cd` into your project directory and run:

```bash
pyenv activate python-package-template
copier path/to/python-package-template path/to/your_project
```

-or-

```bash
copier gh:sabard/python-package-template .
```

### Update an existing template

After making changes to the template:

```bash
cd path/to/your_project
pyenv activate python-package-template
copier update
pyenv deactivate
```

## Publish Package

TODO (consider moving into template)
