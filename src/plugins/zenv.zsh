# zenv
#
# .zenv
#   ZENV_NAME=

function _zenv_init() {

    ZENV_CONFIG_DIR=${ZENV_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zenv}
    ZENV_SHORTCUTS_DIR=${ZENV_SHORTCUTS_DIR:-$ZENV_CONFIG_DIR/shortcuts}
    ZENV_FILE=${ZENV_FILE:-.zenv}
    ZENV_DEPTH=${ZENV_DEPTH:=0}

    if [[ ! -d $ZENV_CONFIG_DIR ]]; then
        mkdir -p $ZENV_CONFIG_DIR
    fi

    if [[ ! -d $ZENV_SHORTCUTS_DIR ]]; then
        mkdir -p $ZENV_SHORTCUTS_DIR
    fi

    if [[ -n $ZENV ]]; then
        _zenv_entered
    fi
}

function _zenv_entered() {
    print -P  "${zfg[cyan]}>>> Entered a state of Zenv: $ZENV >>>${zfg[no]}" >&2

    cd $ZENV
    source ${ZENV_FILE}

    ZENV_NAME=${ZENV_NAME:-${PWD:t}}

    _zenv_set_shortcut

    zen-prompt add-dirsub _zenv_get_prompt_dirsub
    zen-prompt add-part _zenv_get_prompt_part
}

function _zenv_enter() {

    local shortcut=$1
    local target
    if [[ -r $ZENV_SHORTCUTS_DIR/$shortcut ]]; then
        target=$(head -n 1 $ZENV_SHORTCUTS_DIR/$shortcut)
    else
        target=${1:A} # Do path expansion
    fi

    if ! _zenv_check $target; then
        return 1
    fi
    env ZENV=$target ZENV_DEPTH=$((ZENV_DEPTH + 1)) ZDOTDIR=$ZDOTDIR zsh -i

    print -P "${zfg[cyan]}<<< Exited a state of Zenv: $target <<<${zfg[no]}" >&2
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

function _zenv_set_shortcut() {
    echo $ZENV >$ZENV_SHORTCUTS_DIR/$ZENV_NAME
}

_zenv_init

alias zenv=_zenv_enter
