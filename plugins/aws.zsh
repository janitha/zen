function _zen_prompt_aws__part() {
    [[ -z $AWS_SECRET_KEY && -z $AWS_SECRET_ACCESS_KEY ]] && return

    if [[ -z $AWS_USER ]]; then
        print -Rn "${zfg[red]}(aws)${zfg[no]}"
    else
        print -Rn "${zfg[red]}(aws:${AWS_USER})${zfg[no]}"
    fi
}

zen-prompt add-part _zen_prompt_aws__part
