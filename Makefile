export ZDOTDIR = $(CURDIR)/test
export ZEE_ROOT_DIR = $(CURDIR)/src


#export ZEE_DEV="-x"

.PHONY: subshell
subshell:
	env -i \
	ZDOTDIR=$(ZDOTDIR) \
	ZEE_ROOT_DIR=$(ZEE_ROOT_DIR) \
	ZEE_DEV=${ZEE_DEV} \
	TERM=$(TERM) \
	PS4="%F{yellow}%B+%2N:%i>%b%f" \
	zsh -i ${ZEE_DEV}
