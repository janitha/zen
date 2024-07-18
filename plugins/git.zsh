function _zen_prompt_git__branch() {
    git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null
}

function _zen_prompt_git__dirty() {
    git diff --no-ext-diff --quiet --exit-code && return
    print -Rn "${zfg[lightcyan]}±"
}

function _zen_prompt_git__part() {

    local branch=$(_zen_prompt_git__branch)
    [[ -z $branch ]] && return

    local dirty=$(_zen_prompt_git__dirty)

    local color="${zfg[cyan]}"
    local str=""
    str+="${color}("
    str+="${color}${branch}"
    str+="${color}${dirty}"
    str+="${color})"
    str+="${zfg[no]}"

    print -Rn "${str}"
}

zen-prompt add-part _zen_prompt_git__part
