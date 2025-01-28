# Main NuShell configuration (equivalent to .zshrc)
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { || starship prompt }
$env.PROMPT_COMMAND_RIGHT = { || starship prompt --right }

# Aliases (equivalent to .aliases)
alias ls = ls -l
alias la = ls -la
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ~ = cd ~
alias - = cd -
alias pd = cd -

# Git aliases
alias gs = git status
alias gd = git diff
alias gcm = git commit -m
alias gc = git commit
alias gfo = git fetch origin
alias gpom = git pull origin master
alias gpu = git push -u

# Directory navigation
def mkcd [dir: string] {
  mkdir $dir
  cd $dir
}

# Environment variable helpers
def m [msg: string] {
  $env.GEN_MSG = $msg
}

def cm [] {
  hide-env GEN_MSG
}

# Commit message helper
def jgcm [msg: string] {
  git commit -m $"($env.GEN_MSG): ($msg)"
}

# Homebrew configuration
$env.HOMEBREW_NO_AUTO_UPDATE = 1

# Direnv integration TODO:
# direnv hook nu | save -f ~/.config/direnv/direnvrc
# direnv reload

# Mamba initialization
$env.MAMBA_EXE = '/opt/homebrew/opt/micromamba/bin/mamba'
$env.MAMBA_ROOT_PREFIX = '/Users/dhruv/Code/dotfiles/nu'

# Pyenv configuration
$env.PYENV_ROOT = $"($env.HOME)/.pyenv"
$env.PATH = ($env.PATH | prepend $"($env.PYENV_ROOT)/bin")

# Z-jump integration @TODO:
# def __z_add [] {
#   let path = ($env.PWD | str replace $env.HOME '~')
#   z --add $path
# }
# def-env z [query?: string] {
#   let query = ($query | default '')
#   let path = (z --query $query | lines | first)
#   if $path != null {
#     cd $path
#   }
# }

# History configuration
$env.HISTORY_FILE = $"($env.HOME)/.local/share/nushell/history.txt"
$env.HISTORY_FILE_SIZE = 9999999
$env.SAVEHIST = 9999999

# FZF integration @TODO:
# source ~/.fzf.nu

# Interactive shell configuration
$env.PROMPT_INDICATOR = "(nu) "
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Completion configuration @TODO:
# source ~/.config/nushell/completions.nu
