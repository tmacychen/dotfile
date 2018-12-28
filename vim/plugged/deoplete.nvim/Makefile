PATH := ./vim-themis/bin:$(PATH)
export THEMIS_VIM  := nvim
export THEMIS_ARGS := -e -s --headless
export THEMIS_HOME := ./vim-themis


PIP := pip3

install: vim-themis
	$(PIP) install neovim --upgrade
	$(PIP) install pytest --upgrade
	$(PIP) install flake8 --upgrade
	$(PIP) install mypy --upgrade
	$(PIP) install vim-vint --upgrade
	$(PIP) install pytest-cov --upgrade

lint:
	vint --version
	vint plugin
	vint autoload
	flake8 --version
	flake8 rplugin/python3/deoplete
	mypy --version
	mypy --ignore-missing-imports --follow-imports=skip rplugin/python3/deoplete

test:
	themis --version
	themis test/autoload/*
	pytest --version
	pytest

vim-themis:
	proxychains git clone https://github.com/thinca/vim-themis vim-themis

.PHONY: install lint test
