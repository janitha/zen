function _zee_prompt_render_git() {

    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [[ -z $branch ]] && return

    print -Rn "${zfg[cyan]}(${branch})${zfg[no]}"
}

zee-prompt-part-add _zee_prompt_render_git
