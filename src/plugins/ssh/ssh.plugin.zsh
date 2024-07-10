function _zen_prompt_ssh__part() {
    [[ -z $SSH_CLIENT ]] && return
    print -Rn "${zfg[purple]}(ssh)${zfg[no]}"
}

function _zen_prompt_ssh__init() {
    zen-prompt add-part _zen_prompt_ssh__part
}

_zen_prompt_ssh__init
