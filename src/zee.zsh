ZEE_ROOT_DIR=${ZEE_DOOR_DIR:=~/.zee}
ZEE_PLUGIN_DIR=${ZEE_PLUGIN_DIR:=$ZEE_ROOT_DIR/plugins}

declare -A ZEE_PLUGINS

function zee() {
    local command=$1
    shift
    case $command in
        init)
            _zee_init "$@"
            ;;
        load)
            _zee_load "$@"
            ;;
        *)
            echo "Invalid command: $command"
            ;;
    esac
}

function _zee_init() {
    # TODO: Skip if the function has already initialized

    ZEE_ROOT_DIR=~/.zee
    ZEE_PLUGIN_DIR=$ZEE_ROOT_DIR/plugins

    # Create the plugin directory if it doesn't exist
    if [[ ! -d $ZEE_PLUGIN_DIR ]]; then
        mkdir -p $ZEE_PLUGIN_DIR
    fi
}

function _zee_load() {
    local plugin_name=$1
    local plugin_file=$ZEE_PLUGIN_DIR/$plugin_name.zsh

    if [[ -n $ZEE_PLUGINS[$plugin_name] ]]; then
        return 0
    fi

    if [[ ! -r $plugin_file ]]; then
        echo "Plugin $plugin_name not found"
        return 1
    fi

    source $plugin_file
    ZEE_PLUGINS[$plugin_name]=1
}


# Load all plugins in the plugin directory
# function _load_all_plugins() {
#     for plugin_file in $ZEE_PLUGIN_DIR/*.zsh; do
#         source "$plugin_file"
#     done
# }

# Hook into the precmd function
precmd_functions+=(precmd_hook)

# Define the precmd hook function
precmd_hook() {
    # Run precmd logic here
}

# Define the prompt function
prompt() {
    # Run prompt logic here
}

# Set the PROMPT variable to use the custom prompt function
PROMPT='$(zee)'

