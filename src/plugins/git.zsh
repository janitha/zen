function _zee_prompt_render_git() {

    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -z $branch ]] && return

    local color="${zfg[cyan]}"

    print -Rn "${color}(${branch}"
    _zee_prompt_render_git_dirty
    print -Rn "${color})${zfg[no]}"
}

function _zee_prompt_render_git_dirty() {

    local color="${zfg[cyan]}"

    if ! git diff --no-ext-diff --quiet --exit-code; then
        print -Rn "${color}±"
    fi
}

zee-prompt-part-add _zee_prompt_render_git
