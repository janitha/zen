function _zenv_init() {

    ZENV_CONFIG_DIR=${ZENV_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zenv}
    ZENV_FILE=${ZENV_FILE:-.zenv}
    ZENV_DEPTH=${ZENV_DEPTH:=0}

    if [[ ! -d $ZENV_CONFIG_DIR ]]; then
        mkdir -p $ZENV_CONFIG_DIR
    fi

    if [[ -n $ZENV ]]; then
        _zenv_entered
    fi
}

function _zenv_entered() {
    echo ">>> Zenv entered $ZENV >>>" >&2

    cd $ZENV
    source ${ZENV_FILE}

    ZENV_NAME=${ZENV_NAME:-${PWD:t}}

    zen-prompt add-dirsub _zenv_get_prompt_dirsub
    zen-prompt add-part _zenv_get_prompt_part
}

function _zenv_check() {
    local target=$1

    if [[ -z $target ]]; then
        echo "Usage: $0 <target>" >&2
        return 1
    fi

    if [[ ! -d $target ]]; then
        echo "Not a directory: $target" >&2
        return 1
    fi

    if [[ ! -f $target/.zenv ]]; then
        echo "Not a zenv directory: $target" >&2
        return 1
    fi
}

function _zenv_enter() {
    local target=${1:A} # Do path expansion
    if ! _zenv_check $target; then
        return 1
    fi
    env ZENV=$target ZENV_DEPTH=$((ZENV_DEPTH + 1)) ZDOTDIR=$ZDOTDIR zsh -i

    echo "<<< Zenv exited $target <<<" >&2
}

function _zenv_get_prompt_part() {
    if [[ $PWD != $ZENV* ]]; then
        print -Rn "${zfg[lightred]}"
    else
        print -Rn "${zfg[yellow]}"
    fi

    print -Rn "("
    for ((i = 0; i < $ZENV_DEPTH; i++)); do
        print -Rn "ž"
    done
    print -Rn ")"
}

function _zenv_get_prompt_dirsub() {
    local newpwd=$1
    local from=$ZENV
    local to="($ZENV_NAME)"
    newpwd=${newpwd/$from/$to}

    print -Rn $newpwd
}

_zenv_init

alias zenv=_zenv_enter
