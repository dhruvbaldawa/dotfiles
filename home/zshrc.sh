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
export HISTSIZE=9999999
export HISTFILESIZE=9999999
export SAVEHIST=${HISTSIZE}
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt HIST_IGNORE_ALL_DUPS
unsetopt SHARE_HISTORY             # Share history between all sessions.

# Install fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup pyenv environment variables
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Disable the virtualenv prompt.
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENVWRAPPER_WORKON_CD=0
if command -v pyenv-virtualenvwrapper_lazy 1>/dev/null 2>&1; then
  pyenv virtualenvwrapper_lazy
fi

# rupa/z
source "$HOME/bin/z"

# homebrew
[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# direnv
eval "$(direnv hook zsh)"

# Start antigen and use more plugins
source "$HOME/.antigen/antigen.zsh"
antigen bundle akoenig/gulp.plugin.zsh
antigen bundle unixorn/tumult.plugin.zsh
antigen bundle srijanshetty/zsh-pip-completion
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle greymd/docker-zsh-completion
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle changyuheng/fz
antigen bundle zsh-users/zsh-completions
antigen bundle darvid/zsh-poetry
antigen bundle dbz/kube-aliases
antigen bundle jonmosco/kube-ps1
antigen apply


[[ -f "$HOME/.aliases" ]] && source $HOME/.aliases
[[ -f "$HOME/.functions" ]] && source $HOME/.functions
[[ -f "$HOME/.extra" ]] && source $HOME/.extra
# autoload -U compinit && compinit
