# Zen

if [[ -z $ZSH_VERSION ]]; then
    echo "$0: zsh is required for zen" >&2
    return 1
fi

# https://wiki.zshell.dev/community/zsh_plugin_standard#zero-handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

ZEN_BASE_DIR=${ZEN_BASE_DIR:-${0:h}}
ZEN_FUNCTION_DIR=${ZEN_FUNCTION_DIR:-${ZEN_BASE_DIR}/functions}
ZEN_PLUGIN_DIR=${ZEN_PLUGIN_DIR:-$ZEN_BASE_DIR/plugins}

fpath+=($ZEN_FUNCTION_DIR)

autoload -Uz zen
