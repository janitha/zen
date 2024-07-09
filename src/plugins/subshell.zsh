function _zee_subshell_init() {
    if [[ -n $ZEE_SUBSHELL ]]; then
        _zee_subshell_entered
        #unset ZEE_SUBSHELL
    fi
    ZEE_SUBSHELL_DEPTH=${ZEE_SUBSHELL_DEPTH:=0}
}

function _zee_subshell_entered() {
    _zee_stderr "Entered zee subshell $ZEE_SUBSHELL"

    cd $ZEE_SUBSHELL
    source .zee

    ZEE_SUBSHELL_NAME=${ZEE_SUBSHELL_NAME:-${PWD:t}}

    zee-prompt-dirsub-add $PWD "(${ZEE_SUBSHELL_NAME})"
    zee-prompt-part-add _zee_subshell_get_prompt_part
}

function _zee_subshell_is_zee_dir() {
    local target=$1

    if [[ -z $target ]]; then
        _zee_stderr "Usage: $0 <target>"
        return 1
    fi

    if [[ ! -d $target ]]; then
        _zee_stderr "Not a directory: $target"
        return 1
    fi

    if [[ ! -f $target/.zee ]]; then
        _zee_stderr "Not a zee directory: $target"
        return 1
    fi
}

function _zee_subshell_enter() {
    local target=${1:A} # Do path expansion
    local new_depth=$((ZEE_SUBSHELL_DEPTH + 1))
    if ! _zee_subshell_is_zee_dir $target; then
        return 1
    fi
    env ZEE_SUBSHELL=$target ZEE_SUBSHELL_DEPTH=$new_depth zsh -i -x
}

function _zee_subshell_get_prompt_part() {
    if [[ $PWD != $ZEE_SUBSHELL* ]]; then
        print -Rn "${zfg[lightred]}(subshell:?)"
    fi
}

_zee_subshell_init

alias zee-subshell=_zee_subshell_enter
alias work=_zee_subshell_enter

# TODO: chpwd when current path is outside target, warn and/or put something on prompt
