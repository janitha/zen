function _zee_prompt_render_virtualenv() {
    [[ -n $VIRTUAL_ENV ]] || return
    print -Rn "${zfg[green]}(venv)${zfg[no]}"
}

zee-prompt-part-add _zee_prompt_render_virtualenv

export VIRTUAL_ENV_DISABLE_PROMPT=1
