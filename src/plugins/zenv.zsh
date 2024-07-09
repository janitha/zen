function _zenv_init() {
    ZENV_CONFIG_DIR=${ZENV_RC_DIR:-$HOME/.config/zenv}
    ZENV_FILE=${ZENV_FILE:-.zenv}
    ZENV_DEPTH=${ZENV_DEPTH:=0}

    # if [[ ! -d $ZENV_CONFIG_DIR ]]; then
    #     mkdir -p $ZENV_CONFIG_DIR
    # fi

    if [[ -n $ZENV ]]; then
        _zenv_entered
    fi
}

function _zenv_entered() {
    _zee_stderr "Entered a state of Zenv $ZENV"

    cd $ZENV
    source ${ZENV_FILE}

    ZENV_NAME=${ZENV_NAME:-${PWD:t}}

    zee-prompt-dirsub-add $PWD "(${ZENV_NAME})"
    zee-prompt-part-add _zenv_get_prompt_part
}

function _zenv_dir_check() {
    local target=$1

    if [[ -z $target ]]; then
        _zee_stderr "Usage: $0 <target>"
        return 1
    fi

    if [[ ! -d $target ]]; then
        _zee_stderr "Not a directory: $target"
        return 1
    fi

    if [[ ! -f $target/.zenv ]]; then
        _zee_stderr "Not a zenv directory: $target"
        return 1
    fi
}

function _zenv_enter() {
    local target=${1:A} # Do path expansion
    local new_depth=$((ZENV_DEPTH + 1))
    if ! _zenv_dir_check $target; then
        return 1
    fi
    env ZENV=$target ZENV_DEPTH=$new_depth zsh -i
}

function _zenv_get_prompt_part() {
    if [[ $PWD != $ZENV* ]]; then
        print -Rn "${zfg[lightred]}(!zenv)"
    fi
}

_zenv_init

alias zenv=_zenv_enter

# TODO: chpwd when current path is outside target, warn and/or put something on prompt
