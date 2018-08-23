DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
PET := $(shell command -v pet 2> /dev/null)
GIBO := $(shell command -v gibo 2> /dev/null)
ZPLUG := $(shell command -v zplug 2> /dev/null)
NODE := $(shell command -v node 2> /dev/null)
YARN := $(shell command -v yarn 2> /dev/null)
HUB := $(shell command -v hub 2> /dev/null)
RUBY := $(shell command -v ruby 2> /dev/null)
BUNDLER := $(shell command -v bundler 2> /dev/null)
GO := $(shell command -v go 2> /dev/null)
BREW := $(shell command -v brew 2> /dev/null)
PIP := $(shell command -v pip 2> /dev/null)


all: init

.PHONY: install
install:
	./install.sh

.PHONY: init-full
init-full: init-sh-full gibo zplug node yarn pet hub pip

.PHONY: init-sh-full
init-sh-full: install
	./init.sh --full

.PHONY: gibo
gibo:
ifndef GIBO
	./src/install_gibo.sh
endif

.PHONY: pet
pet:
ifndef PET
	./src/install_pet.sh
endif

.PHONY: zplug
zplug:
ifndef ZPLUG
	./src/install_zplug.sh
endif

.PHONY: brew
brew:
ifnder BREW
	./src/install_brew.sh
endif

.PHONY: go
go:
ifndef GO
	./src/install_go.sh
endif

.PHONY: ruby
ruby:
ifndef RUBY
	./src/install_ruby.sh
endif

.PHONY: bundler
bundler:
ifndef BUNDLER
	./src/install_bundler.sh
endif

.PHONY: hub
hub: go brew ruby bundler
ifndef HUB
	./src/install_hub.sh
endif

.PHONY: node
node:
ifndef NODE
	./src/install_node.sh
endif

.PHONY: yarn
yarn: node
ifndef YARN
	./src/install_yarn.sh
endif

.PHONY: pip
pip:
ifndef PIP
	./src/install_pip.sh
endif
