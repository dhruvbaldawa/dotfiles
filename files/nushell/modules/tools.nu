
# Homebrew shell environment
load-env (^brew shellenv | capture-foreign-env --shell /bin/bash | transpose -r -d)
# Homebrew configuration
$env.HOMEBREW_NO_AUTO_UPDATE = 1

# fzf
def fzf-file-picker [] {
    let selected = (^find . -type f -depth 1 | fzf --height 40% --reverse | str trim)
    if $selected != "" { commandline edit --insert $selected }
}

# @TODO: zoxide
# @TODO: carapace
# @TODO: atuin
# @TODO: nu_scripts aliases
