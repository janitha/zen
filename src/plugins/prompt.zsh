# [ USERNAME @ HOSTNAME PWD ] %
# [ USERNAME @ HOSTNAME ~ ] %
# [ USERNAME @ HOSTNAME (SOMEDIR)/some/path (git branch) ] %

# zee-prompt

# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

function _zee_prompt_init() {

    typeset -ag ZEE_PROMPT_PARTS
    typeset -Ag ZEE_PROMPT_DIRSUBS

    _zee_prompt_color_init

    setopt prompt_subst

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _zee_prompt_precmd
    # add-zsh-hook preexec _zee_prompt_preexec
    # add-zsh-hook chpwd _zee_prompt_chpwd

    _zee_prompt_color_init
}

function _zee_prompt_color_init() {

    # https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
    # https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting
    # https://github.com/zsh-users/zsh/blob/master/Functions/Misc/colors

    typeset -A _zcolors
    _zcolors=(
        0 black
        1 red
        2 green
        3 yellow
        4 blue
        5 purple
        6 cyan
        7 gray
        8 darkgray
        9 lightred
        10 lightgreen
        11 lightyellow
        12 lightblue
        13 lightpurple
        14 lightcyan
        15 white
    )

    typeset -Ag zfg zbg

    for i in {0..15}; do
        zfg[${_zcolors[$i]}]="%${i}F"
        zbg[${_zcolors[$i]}]="%${i}K"
    done

    zfg[no]="%f%b%u%s"
    zbg[no]="%k"
}

function _zee_prompt_precmd() {
    PROMPT="$(_zee_prompt_render)"
    # _zee_stderr $PROMPT
}

# function _zee_prompt_preexec() {
#     return
# }

# function _zee_prompt_chpwd() {
#     return
# }

function _zee_prompt_render() {

    # https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

    local sep_color="${zfg[purple]}"
    local sep_left="${zfg[purple]}["
    local sep_right="${zfg[purple]}]"
    local sep_at="${zfg[purple]}@"

    local priv_color="%(!,${zfg[lightred]},${zfg[yellow]})"
    local username="${priv_color}%n"
    local hostname="${zfg[cyan]}%m"
    local priv="${priv_color}%#"

    print -Rn "${sep_left}${username}${sep_at}${hostname} "
    _zee_prompt_render_dir
    print -Rn "${sep_right}"
    _zee_prompt_render_parts
    print -Rn "${priv} "
    print -Rn "${zfg[no]}${zbg[no]}"
}

function _zee_prompt_render_dir() {
    local newpwd=$PWD
    local newcolor=${zfg[yellow]}
    local defcolor=${zfg[lightblue]}

    for from to in ${(@kv)ZEE_PROMPT_DIRSUBS}; do
        newpwd=${newpwd/$from/"${newcolor}${to}${defcolor}"}
    done

    newpwd=${newpwd/$HOME/"${newcolor}~${defcolor}"}

    print -Rn "${zfg[lightblue]}${newpwd}"
}

function _zee_prompt_render_parts() {
    # if [[ -n $ZEE_PROMPT_PARTS ]]; then
    #     print -Rn "${zfg[no]}"
    # fi

    for part in $ZEE_PROMPT_PARTS; do
        print -Rn "${zfg[no]}${zbg[no]}"
        $part
    done
}

function zee-prompt-part-add() {
    ZEE_PROMPT_PARTS+=($1)
}

function zee-prompt-dirsub-add() {
    ZEE_PROMPT_DIRSUBS+=($1 $2)
}

_zee_prompt_init

# TODO: Implement "zee-prompt add --before <other> func"
# zee-prompt add <part>
# zee-prompt add --before <other> --before <asdf> <part>
# zee-prompt add --after <other> <part>
# zee-prompt add --beginning <part>
# zee-prompt add --end <part>
# zee-prompt remove <part>

# function old_precmd() {

#     PS1_LBR="$fg[dark-purple]["
#     PS1_RBR="$fg[dark-purple]]"
#     PS1_PWD_PRE="$fg[light-blue]"
#     PS1_PWD_END="$fg[light-blue]"
#     PS1_PRIV="%(!,$fg[light-red],$fg[gray])%#"
#     PS1_END="$fg[no] "

#     PWD_PROCESSED=$PWD
#     PWD_PROCESSED=${PWD_PROCESSED/$PS1_PWD_SUB/$fg[dark-yellow]$PS1_PWD_STR$PS1_PWD_END}
#     PWD_PROCESSED=${PWD_PROCESSED/$HOME/"~"}

#     USERSHORT=${USER/"jkarunaratne"/"j"}

#     PS1="$PS1_LBR"
#     PS1+="%(!,$fg[light-red],$fg[dark-yellow])$USERSHORT$fg[dark-purple]@$fg[dark-cyan]%m "
#     PS1+="$PS1_PWD_PRE$PWD_PROCESSED$PS1_RBR"
#     PS1+="$PS1_AWS$PS1_VIRTUALENV$PS1_PRIV$PS1_END"
# }

# function asdf() {
#     export _PS1_VIRTUALENV="$fg[light-green](virtualenv)"

#     export _PS1_AWS="$fg[light-red](aws)"
#     export _PS1_GIT="$fg[dark-green]"
# }
