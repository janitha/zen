# Zen
#
# zen init
# zen plugin load prompt
# zen

# PS4="%(?..%1FErrAbove)%F{yellow}%B+%2N:%i>%b%f"
# set -x

if [[ -z $ZSH_VERSION ]]; then
    echo "$0: zsh is required for zen" >&2
    return
fi

ZEN_ROOT_DIR=${ZEN_ROOT_DIR:-$(dirname "$(realpath "$0")")}
ZEN_PLUGIN_DIR=${ZEN_PLUGIN_DIR:-$ZEN_ROOT_DIR/plugins}

function _zen_cmd_init() {

    if [[ -n $ZEN_INITIALIZED ]]; then
        echo "$0: Already initialized" >&2
        return 1
    fi

    if [[ ! -d $ZEN_PLUGIN_DIR ]]; then
        mkdir -p $ZEN_PLUGIN_DIR
    fi

    source $ZEN_ROOT_DIR/utils.zsh

    ZEN_INITIALIZED=1
}

function _zen_cmd_load() {

    # TODO: Support loading plugin by path
    # TODO: Support loading plugin by URL (git clone)

    if [[ $# -eq 0 ]]; then
        echo "$0: Plugin name required" >&2
        return 1
    fi

    local plugin_name=$1
    local plugin_file

    # Try to load plugin as single file
    plugin_file=${ZEN_PLUGIN_DIR}/${plugin_name}/${plugin_name}.plugin.zsh
    if [[ -r try_file ]]; then
        source $plugin_file
        return
    fi

    # Try to load plugin as a dir in the $ZEN_PLUGIN_DIR
    plugin_file=${ZEN_PLUGIN_DIR}/${plugin_name}.zsh
    if [[ -r $plugin_file ]]; then
        source $plugin_file
        return
    fi

}

function zen() {

    # TODO: Use zparseopts

    if [[ $# -eq 0 ]]; then
        echo "$0: Subcommand required" >&2
        return 1
    fi

    local command=$1
    shift
    case $command in
    init)
        _zen_cmd_init "$@"
        ;;
    load)
        _zen_cmd_load "$@"
        ;;
    *)
        echo "$0: Invalid subcommand: $command" >&2
        return 1
        ;;
    esac

}
