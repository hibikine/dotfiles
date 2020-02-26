DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
PET := $(shell command -v pet 2> /dev/null)
ZSH := $(shell command -v zsh 2> /dev/null)
ZPLUG := $(shell command -v zplug 2> /dev/null)
NODE := $(shell command -v node 2> /dev/null)
YARN := $(shell command -v yarn 2> /dev/null)
HUB := $(shell command -v hub 2> /dev/null)
RUBY := $(shell command -v ruby 2> /dev/null)
RBENV := $(shell command -v rbenv 2> /dev/null)
BUNDLER := $(shell command -v bundler 2> /dev/null)
TRAVIS := $(shell command -v travis 2> /dev/null)
GO := $(shell command -v go 2> /dev/null)
BREW := $(shell command -v brew 2> /dev/null)
PYTHON := $(shell command -v python 2> /dev/null)
PIP := $(shell command -v pip 2> /dev/null)
CURL := $(shell command -v curl 2> /dev/null)
NVIM := $(shell command -v nvim 2> /dev/null)
PHP := $(shell command -v php 2> /dev/null)
COMPOSER := $(shell command -v composer 2> /dev/null)
PEEK := $(shell command -v peek 2> /dev/null)
TASK := $(shell command -v task 2> /dev/null)
VIM := $(shell command -v vim 2> /dev/null)
YVM := $(shell command -v yvm 2> /dev/null)
GVM := $(shell command -v gvm 2> /dev/null)
RIPGREP := $(shell command -v rg 2> /dev/null)
RUSTUP := $(shell command -v rustup 2> /dev/null)
EXA := $(shell command -v exa 2> /dev/null)
ARG=sample

all: init

.PHONY: init
init: init-sh zplug taskwarrior

.PHONY: full
full: init-full

.PHONY: install
install:
	./install.sh; ./src/config_wsl.sh

.PHONY: init-tools
init-tools: zplug pet exa

.PHONY: init-full
init-full: init-sh-full zplug node yarn pet pip nvim yvm gvm peek taskwarrior ripgrep rustup exa

.PHONY: init-sh
init-sh: install
	./init.sh

.PHONY: init-sh-full
init-sh-full: install
	./init.sh --full

tests/assert.sh:
	wget https://raw.github.com/lehmannro/assert.sh/master/assert.sh -P tests
	chmod 755 tests/assert.sh

.PHONY: clean
clean:
	rm -f ./tests/assert.sh

.PHONY: test
test: tests/assert.sh
	cd tests; ./tests.sh

.PHONY: pet
pet: zplug brew curl
ifndef PET
	cd src; ./install_pet.sh
endif

.PHONY: zsh
zsh:
ifndef ZSH
	cd src; ./install_zsh.sh
endif

.PHONY: zplug
zplug: zsh
ifndef ZPLUG
	cd src; ./install_zplug.sh
endif

.PHONY: brew
brew:
ifndef BREW
	if [ "$$(uname)" = 'Darwin' ]; then \
		cd src; ./install_homebrew.sh; \
	fi
endif

.PHONY: go
go:
ifndef GO
	cd src; ./install_go.sh
endif

.PHONY: rbenv
rbenv:
ifndef RBENV
	cd src;\./install_rbenv.sh
endif

.PHONY: ruby
ruby:rbenv
ifndef RUBY
	cd src; ./install_ruby.sh
endif

.PHONY: bundler
bundler: ruby
ifndef BUNDLER
	cd src; ./install_bundler.sh
endif

.PHONY: travis
travis: ruby
ifndef TRAVIS
	cd src; ./install_travis.sh
endif

.PHONY: hub
hub: brew
ifndef HUB
	cd src; ./install_hub.sh
endif

.PHONY: node
node: curl
ifndef NODE
	cd src; ./install_node.sh
endif

.PHONY: yarn
yarn: node
ifndef YARN
	cd src; ./install_yarn.sh; ./set_yarn_config.sh
endif

.PHONY: yvm
yvm: node
ifndef YVM
	cd src; ./install_yvm.sh
endif

.PHONY: python
python:
ifndef PYTHON
	cd src; ./install_python.sh
endif

.PHONY: pip
pip: python
ifndef PIP
	cd src; ./install_pip.sh
endif

.PHONY: curl
curl:
ifndef CURL
	cd src; ./install_curl.sh
endif

.PHONY: nvim
nvim: curl
ifndef NVIM
	cd src; ./install_neovim.sh
endif

.PHONY: php
php:
ifndef PHP
	cd src; ./install_php.sh
endif

.PHONY: composer
composer:
ifndef COMOPSER
	cd src; ./install_composer.sh
endif

.PHONY: peek
peek:
ifndef PEEK
	cd src; ./install_peek.sh
endif

.PHONY: gvm
gvm:
ifndef GVM
	cd src; ./install_gvm.sh
endif

.PHONY: taskwarrior
taskwarrior:
ifndef TASK
	cd src; ./install_taskwarrior.sh
endif

.PHONY: tpm
tpm:
	cd src; ./install_tpm.sh

.PHONY: gen-install-script
gen-install-script: yarn
	yarn hygen install-script new ${ARG}

.PHONY: rustup
rustup:
ifndef RUSTUP
	cd src; ./install_rustup.sh
endif

.PHONY: ripgrep
ripgrep:
ifndef RIPGREP
	cd src; ./install_ripgrep.sh
endif

.PHONY: exa
exa: rustup
ifndef EXA
	cd src; ./install_exa.sh
endif

.PHONY: proxy-auto-toggle
proxy-auto-toggle:
	sudo ln -sf ~/dotfiles/etc_settings/NetworkManager/dispatcher.d/ProxyAutoToggle.zsh /etc/NetworkManager/dispatcher.d/ProxyAutoToggle.zsh
