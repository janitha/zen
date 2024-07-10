function _zen_prompt_ssh__part() {
    [[ -n $SSH_CLIENT ]] || return
    print -Rn "${zfg[purple]}(ssh)${zfg[no]}"
}

function _zen_prompt_ssh__init() {
    zen-prompt-part-add _zen_prompt_ssh__part
}

_zen_prompt_ssh__init
