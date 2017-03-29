#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

unsetopt SHARE_HISTORY             # Share history between all sessions.

# Disable the virtualenv prompt.
export VIRTUAL_ENV_DISABLE_PROMPT=1
source `which virtualenvwrapper.sh`
source "$HOME/bin/z"

# Start antigen and use more plugins
source "$HOME/.antigen/antigen.zsh"
antigen bundle akoenig/gulp.plugin.zsh
antigen bundle zsh-users/zsh-completions
#antigen bundle unixorn/git-extra-commands
antigen bundle unixorn/tumult.plugin.zsh
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
antigen bundle srijanshetty/zsh-pip-completion
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle supercrabtree/k
antigen apply

[[ -f "$HOME/.aliases" ]] && source $HOME/.aliases
[[ -f "$HOME/.functions" ]] && source $HOME/.functions
[[ -f "$HOME/.extra" ]] && source $HOME/.extra
