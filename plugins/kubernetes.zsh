function _zen_prompt_kubernetes__part() {
    [[ -z $KUBECONFIG ]] && return
    print -Rn "${zfg[lightblue]}(k8s)${zfg[no]}"
}

zen-prompt add-part _zen_prompt_kubernetes__part
