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
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
unsetopt SHARE_HISTORY       # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.
setopt PROMPT_SP
setopt prompt_subst interactive_comments  # for starship prompt

# Install fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Install starship
command -v starship &>/dev/null || sh -c "$(curl -fsSL https://starship.rs/install.sh)"

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
export HOMEBREW_NO_AUTO_UPDATE=1
[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# direnv
eval "$(direnv hook zsh)"

# nvm
export NVM_LAZY_LOAD=true

# Start antigen and use more plugins
source "$HOME/.antigen/antigen.zsh"
antigen bundle unixorn/tumult.plugin.zsh
antigen bundle greymd/docker-zsh-completion
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle changyuheng/fz
antigen bundle zsh-users/zsh-completions
antigen bundle dbz/kube-aliases
# antigen bundle lukechilds/zsh-nvm
antigen apply

[[ -f "$HOME/.aliases" ]] && source $HOME/.aliases
[[ -f "$HOME/.functions" ]] && source $HOME/.functions
[[ -f "$HOME/.extra" ]] && source $HOME/.extra

autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
