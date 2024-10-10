# dotfiles
![CI](https://github.com/mehmetalici/dotfiles/actions/workflows/docker-build-and-test.yml/badge.svg)

A collection of my configuration files and settings to be applied for a fresh machine. 


## Prerequisites
1. Ubuntu 22.04 (Other versions are not tested)
2. Python >= 3.6
3. git, curl, wget

## Installing
1. Clone repository:
    ```bash
    git clone --recurse-submodules git@github.com:mehmetalici/dotfiles.git
    ```
2. Change to repository and install:
    ```bash
    cd dotfiles
    ./install
    ```

    Note that some installs may fail if they are installed already. By [running tests](#testing), you can find out if they are installed -or the installation fails for another reason.   

## Testing
You can test installation with: 
```bash
./test
```

The actual tests are located in `tests/test.sh`. The script `test` is a thin wrapper for running tests on an interactive shell to ensure that `~/.bashrc` is sourced. 