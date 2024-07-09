bindkey -e

source $ZEE_ROOT_DIR/zee.zsh
zee init

zee load prompt
zee load git
zee load subshell



function zeedev() {
    print -Rn "${zfg[red]}(zeedev)"
}
zee-prompt-part-add zeedev

