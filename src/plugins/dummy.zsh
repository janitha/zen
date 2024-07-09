_zee_stderr "Dummy plugin loading..."

function _dummy_chpwd() {
    _zee_stderr "Dummy plugin chpwd"
}

function _dummy_precmd() {
    _zee_stderr "Dummy plugin precmd"
}

function _dummy_preexec() {
    _zee_stderr "Dummy plugin preexec"
}


autoload -Uz add-zsh-hook
add-zsh-hook chpwd _dummy_chpwd
add-zsh-hook precmd _dummy_precmd
add-zsh-hook preexec _dummy_preexec

_zee_stderr "Dummy plugin loaded"
