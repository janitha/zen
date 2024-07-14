function _zen_prompt_ssh__part() {
    [[ -z $SSH_CLIENT ]] && return
    print -Rn "${zfg[purple]}(ssh)${zfg[no]}"
}

zen-prompt add-part _zen_prompt_ssh__part
