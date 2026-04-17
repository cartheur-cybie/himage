SHELL := /usr/bin/env bash

.PHONY: help install-asl toolchain-check build exact check clean

help:
	@echo "Targets:"
	@echo "  make install-asl      - build/install Macroassembler AS to ~/.local"
	@echo "  make toolchain-check  - show detected assembler tools"
	@echo "  make build            - build NEWFEAT+SERIAL image"
	@echo "  make exact            - build EXACT image"
	@echo "  make check            - verify exact image equals walkup8a"
	@echo "  make clean            - remove generated outputs"

install-asl:
	./scripts/install-asl.sh

toolchain-check:
	./scripts/toolchain-check.sh

build:
	./scripts/build.sh

exact:
	./scripts/build.sh --exact

check:
	./scripts/check.sh

clean:
	./scripts/clean.sh
