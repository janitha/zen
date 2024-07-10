OSTYPE=$(uname -s)
alias is_linux='[[ $OSTYPE == "Linux" ]]'
alias is_darwin='[[ $OSTYPE == "Darwin" ]]'
alias is_macos='[[ $OSTYPE == "Darwin" ]]'
alias is_freebsd='[[ $OSTYPE == "FreeBSD" ]]'

# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting
# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/colors
typeset -A _zcolors
_zcolors=(
    0 black
    1 red
    2 green
    3 yellow
    4 blue
    5 purple
    6 cyan
    7 gray
    8 darkgray
    9 lightred
    10 lightgreen
    11 lightyellow
    12 lightblue
    13 lightpurple
    14 lightcyan
    15 white
)

typeset -Ag zfg zbg
for i in {0..15}; do
    zfg[${_zcolors[$i]}]="%${i}F"
    zbg[${_zcolors[$i]}]="%${i}K"
done
zfg[no]="%f%b%u%s"
zbg[no]="%k"
