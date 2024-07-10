# zen-prompt

# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

function _zen_prompt_init() {

    typeset -g ZEN_PROMPT=1
    typeset -ag ZEN_PROMPT_PARTS
    typeset -ag ZEN_PROMPT_DIRSUBS

    setopt prompt_subst

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _zen_prompt_precmd

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

function _zen_prompt_add_part() {
    if [[ -z $1 ]]; then
        echo "Usage: $0 <part-func>" >&2
        return 1
    fi
    ZEN_PROMPT_PARTS+=($1)
}

function _zen_prompt_add_dirsub() {
    if [[ -z $1 ]]; then
        echo "Usage: $0 <dirsub-func>" >&2
        return 1
    fi
    ZEN_PROMPT_DIRSUBS+=($1)
}

_zen_prompt_init

function zen-prompt() {

    # TODO: Use zparseopts

    if [[ $# -eq 0 ]]; then
        echo "$0: Subcommand required" >&2
        return 1
    fi

    local command=$1
    shift
    case $command in
    add-part)
        _zen_prompt_add_part "$@"
        ;;
    add-dirsub)
        _zen_prompt_add_dirsub "$@"
        ;;
    *)
        echo "$0: Invalid subcommand: $command" >&2
        return 1
        ;;
    esac

}

# TODO: Implement "zen-prompt add --before <other> func"
# zen-prompt add-part <part>
# zen-prompt add-part --before <other> --before <asdf> <part>
# zen-prompt add-part --after <other> <part>
# zen-prompt add-part --beginning <part>
# zen-prompt add-part --end <part>
# zen-prompt remove <part>
