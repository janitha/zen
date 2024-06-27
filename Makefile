export ZDOTDIR = $(CURDIR)/test
export ZEE_ROOT_DIR = $(CURDIR)/src

subshell:
	env -i ZDOTDIR=$(ZDOTDIR) ZEE_ROOT_DIR=$(ZEE_ROOT_DIR) zsh -i
