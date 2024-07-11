# Zen Zsh Framework

A minimal zsh framework.

# Usage

```
source ~/.zen/zen.zsh
zen init
zen load defaults
```

# Fraemwork

## Plugins

Should be placed in to the `zen/plugins` directory, as either a single file or directory that follow the standard omz like plugin standard.

- `zen/plugins/${pluginname}.zsh`
- `zen/plugins/${pluginname}/${pluginnmame}.plugin.zsh`

## Prompt

Included is the zen-prompt plugin, which allow dynamically creating the prompt.

- `zen-prompt add-part <fn>` a fn that will be appeneded towards end of the prompt.
- `zen-prompt add-dirsub <fn>` a fn that can mangle the displayed directory.

```sh
function _dummy_part_info() {
    print -Rn "(dummy)"
}

zen-prompt add-part _dummy_part_info

function _dummy_dirsub() {
    local oldpwd=$PWD
    local newpwd=${PWD/$HOME/~~~}
}
zen-prompt add-dirsub _dummy_dirsub
```
