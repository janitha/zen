


# Plugin Development

## Zsh Hooks

Use `add-zsh-hook` rather than adding directly to the hook functions array, as it ensures functions added are not duplicated, which is important when it comes to subshells.

