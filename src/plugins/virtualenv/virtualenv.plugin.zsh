function _zen_prompt_virtualenv__part() {
    [[ -z $VIRTUAL_ENV ]] && return
    print -Rn "${zfg[green]}(venv)${zfg[no]}"
}

function _zen_prompt_virtualenv__init() {
    zen-prompt add-part _zen_prompt_virtualenv__part
    export VIRTUAL_ENV_DISABLE_PROMPT=1
}

_zen_prompt_virtualenv__init
