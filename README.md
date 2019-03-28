# dotfiles

[![Build Status](https://travis-ci.org/HibikineKage/dotfiles.svg?branch=master)](https://travis-ci.org/HibikineKage/dotfiles) [![CircleCI](https://circleci.com/gh/HibikineKage/dotfiles.svg?style=svg)](https://circleci.com/gh/HibikineKage/dotfiles)

Hibikine Kage's dotfiles.

## Requires

- Windows || OSX || Ubuntu || Debian
- `git`
- `make` on OSX || Ubuntu || Debian

## How to Use

### OSX || Ubuntu || Debian

```bash
cd ~/
git clone https://github.com/HibikineKage/dotfiles.git
cd dotfiles
make

# Install what I need
make composer
make node

# Install all
make full
```

### Windows

Open administrator powershell.

```ps1
cd ~/
git clone https://github.com/HibikineKage/dotfiles.git
cd dotfiles
./install.bat
./init.bat
```

## Test

```bash
make test
```

### Docker Test

```bash
./docker-test.sh
```
