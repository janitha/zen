# Handle $0 according to the standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
#0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
#0="${${(M)0:#/*}:-$PWD/$0}"

echo "$0: Sourcing Begin" >&2

function _dummy__chpwd() {
    echo "$0: chpwd" >&2
}

function _dummy__precmd() {
    echo "$0: precmd" >&2
}

function _dummy__preexec() {
    echo "$0: preexec" >&2
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _dummy__chpwd
add-zsh-hook precmd _dummy__precmd
add-zsh-hook preexec _dummy__preexec

echo "$0: Sourcing Done" >&2
