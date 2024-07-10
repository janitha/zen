function _zen_prompt_git__branch() {
    git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null
}

function _zen_prompt_git__dirty() {
    if ! git diff --no-ext-diff --quiet --exit-code; then
        print -Rn "±"
    fi
}

function _zen_prompt_git__part() {

    local branch=$(_zen_prompt_git__branch)
    [[ -z $branch ]] && return

    local dirty=$(_zen_prompt_git__dirty)
    local color="${zfg[cyan]}"
    local end="${zfg[no]}"

    print -Rn "${color}(${branch}${dirty})${end}"

}

function _zen_prompt_git__init() {
    zen-prompt-part-add _zen_prompt_git__part
}

_zen_prompt_git__init
