# Zen Zsh Framework

A small, modular Zsh plugin framework with a composable prompt system and simple project shell states.

Inspired by oh-my-zsh, but built as an ultra-lightweight alternative for my own personal use.

## Quick start

To your .zshrc file

```sh
source ~/.zen/zen.zsh
zen init
zen load defaults
```

- `zen init`: initialize the plugin directory and shell completion.
- `zen load <name>`: load a plugin from `~/.zen/plugins/<name>.zsh` or `~/.zen/plugins/<name>/<name>.plugin.zsh`.

## Structure

- `zen.zsh`: bootstraps the framework and sets up paths.
- `functions/zen`: defines `zen` subcommands (`init`, `load`).
- `functions/zen-utils`: OS helpers and ANSI color maps used by prompt plugins.
- `plugins/`: built-in plugin files and plugin directories.

## Plugin conventions

Zen supports two plugin formats:

- single-file: `plugins/<name>.zsh`
- directory: `plugins/<name>/<name>.plugin.zsh`

## Built-in plugins

- `prompt`: modular prompt rendering with hookable parts and path transformations.
- `zenv`: in-directory environment state using `.zenv` files and nested shells.
- `git`: repository branch + dirty indicator in prompt.
- `virtualenv`: displays active `VIRTUAL_ENV` marker.
- `kubernetes`: displays `KUBECONFIG` marker.
- `aws`: displays `AWS_*` credential marker.

## Prompt extension API

`zen-prompt` provides:

- `zen-prompt add-part <fn>`: add a function that renders in the right prompt segment.
- `zen-prompt add-dirsub <fn>`: add a function that transforms how `$PWD` is displayed.

### Example

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

## Notes

- `zen load defaults` loads common components in this order: `prompt`, `zenv`, `git`, `virtualenv`, `kubernetes`, `aws`.
- `setopt prompt_subst` is required for the dynamic prompt expression used by `prompt` plugin.

