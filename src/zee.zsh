if [[ -z $ZSH_VERSION ]]; then
    echo "ERROR: ZSH is required to run this script" >&2
    return
fi

function _zee_stderr() {
    local message=$1
    echo -e "\e[1;31;1mzee: $message\e[0m" >&2
}

function zee() {

    local command=$1
    shift
    case $command in
    init)
        _zee_cmd_init "$@"
        ;;
    load)
        _zee_cmd_load "$@"
        ;;
    *)
        _zee_stderr "Invalid command: $command"
        ;;
    esac

}

function _zee_cmd_init() {

    ZEE_ROOT_DIR=${ZEE_ROOT_DIR:=~/.zee}
    export ZEE_ROOT_DIR

    ZEE_PLUGIN_DIR=${ZEE_PLUGIN_DIR:=$ZEE_ROOT_DIR/plugins}
    if [[ ! -d $ZEE_PLUGIN_DIR ]]; then
        mkdir -p $ZEE_PLUGIN_DIR
    fi
}

function _zee_cmd_load() {

    # https://github.com/agkozak/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc

    if [[ $# -eq 0 ]]; then
        _zee_stderr "Plugin name required"
        return 1
    fi

    local plugin_name=$1
    local plugin_file=$ZEE_PLUGIN_DIR/$plugin_name.zsh

    if [[ ! -r $plugin_file ]]; then
        _zee_stderr "Plugin $plugin_name not found"
        return 1
    fi

    source $plugin_file

}
