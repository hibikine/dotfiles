# dotfiles

[![CircleCI](https://circleci.com/gh/hibikine/dotfiles.svg?style=svg)](https://circleci.com/gh/HibikineKage/dotfiles)

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

## Development

### Add new install script

```bash
yarn hygen install-script new hogehoge && chmod +x src/install_hogehoge.sh
# or
make add-install-script ARG=hogehoge && chmod +x src/install_hogehoge.sh
# or
cp src/install_template.sh src/install_hogehoge.sh
```
