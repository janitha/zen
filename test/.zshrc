bindkey -e

source $ZEE_ROOT_DIR/zee.zsh
zee init

zee load prompt
zee load zenv
zee load git
zee load virtualenv
zee load ssh




function zeedev() {
    print -Rn "${zfg[red]}(zee)"
}
if [[ -n "$ZEE_DEV" ]]; then
    zee-prompt-part-add zeedev
fi
