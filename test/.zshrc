bindkey -e

source $ZDOTDIR/../src/zen.zsh

zen init

#zen load dummy
zen load prompt
zen load zenv
zen load git
zen load virtualenv
zen load ssh


function zendev() {
    print -Rn "${zfg[red]}(zen)"
}
#if [[ -n "$ZEN_DEV" ]]; then
    zen-prompt add-part zendev
#fi
