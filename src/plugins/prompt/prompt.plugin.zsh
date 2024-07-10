# [ USERNAME @ HOSTNAME PWD ] %
# [ USERNAME @ HOSTNAME ~ ] %
# [ USERNAME @ HOSTNAME (SOMEDIR)/some/path (git branch) ] %

# zen-prompt

# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

function _zen_prompt_init() {

    typeset -ag ZEN_PROMPT_PARTS
    typeset -ag ZEN_PROMPT_DIRSUBS

    _zen_prompt_color_init

    setopt prompt_subst

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _zen_prompt_precmd
    # add-zsh-hook preexec _zen_prompt_preexec
    # add-zsh-hook chpwd _zen_prompt_chpwd

    _zen_prompt_color_init
}

function _zen_prompt_color_init() {

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

function _zen_prompt_precmd() {
    PROMPT="$(_zen_prompt_render)"
}

# function _zen_prompt_preexec() {
#     return
# }

# function _zen_prompt_chpwd() {
#     return
# }

function _zen_prompt_render() {

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
    _zen_prompt_render_dir
    print -Rn "${sep_right}"
    _zen_prompt_render_parts
    print -Rn "${priv} "
    print -Rn "${zfg[no]}${zbg[no]}"
}

function _zen_prompt_render_dir() {
    local newpwd=$PWD
    local newcolor=${zfg[yellow]}
    local defcolor=${zfg[lightblue]}

    # for from to in ${(@kv)ZEN_PROMPT_DIRSUBS}; do
    #     newpwd=${newpwd/$from/"${newcolor}${to}${defcolor}"}
    # done

    for dirsub in ${ZEN_PROMPT_DIRSUBS}; do
        newpwd=$($dirsub $newpwd)
    done

    newpwd=${newpwd/$HOME/"${newcolor}~${defcolor}"}

    print -Rn "${zfg[lightblue]}${newpwd}"
}

function _zen_prompt_render_parts() {
    # if [[ -n $ZEN_PROMPT_PARTS ]]; then
    #     print -Rn "${zfg[no]}"
    # fi

    for part in $ZEN_PROMPT_PARTS; do
        print -Rn "${zfg[no]}${zbg[no]}"
        $part
    done
}

function zen-prompt-part-add() {
    ZEN_PROMPT_PARTS+=($1)
}

#function zen-prompt-dirsub-add() {
#    ZEN_PROMPT_DIRSUBS+=($1 $2)
#}
function zen-prompt-dirsub-add() {
    ZEN_PROMPT_DIRSUBS+=($1)
}

_zen_prompt_init

# TODO: Implement "zen-prompt add --before <other> func"
# zen-prompt add <part>
# zen-prompt add --before <other> --before <asdf> <part>
# zen-prompt add --after <other> <part>
# zen-prompt add --beginning <part>
# zen-prompt add --end <part>
# zen-prompt remove <part>
