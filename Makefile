DOTPATH := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
GIBO := $(shell command -v gibo 2> /dev/null)
ZPLUG := $(shell command -v zplug 2> /dev/null)
YARN := $(shell command -v yarn 2> /dev/null)

all: init

.PHONY: install
install:
	./install.sh

.PHONY: init-full
init-full: init-sh-full gibo zplug yarn

.PHONY: init-sh-full
init-sh-full: install
	./init.sh --full

.PHONY: gibo
gibo:
ifndef GIBO
	./src/install_gibo.sh
endif

.PHONY: zplug
zplug:
ifndef ZPLUG
	./src/install_zplug.sh
endif

.PHONY: yarn
yarn:
ifndef YARN
	./src/install_yarn.sh
endif
