export ZDOTDIR = $(CURDIR)/test
export XDG_CONFIG_HOME = $(ZDOTDIR)/.config

export ZEN_DEV="-x"

.PHONY: subshell
subshell:
	env -i \
	XDG_CONFIG_HOME=$(XDG_CONFIG_HOME) \
	ZDOTDIR=$(ZDOTDIR) \
	ZEN_DEV=${ZEN_DEV} \
	TERM=$(TERM) \
	PS4="%(?..%1FErrAbove)%F{yellow}%B+%2N:%i>%b%f" \
	zsh -i ${ZEN_DEV}
