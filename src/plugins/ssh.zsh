function _zee_prompt_render_ssh() {
    [[ -n $SSH_CLIENT ]] || return
    print -Rn "${zfg[purple]}(ssh)${zfg[no]}"
}

zee-prompt-part-add _zee_prompt_render_ssh

