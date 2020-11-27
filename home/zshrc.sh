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
export HISTFILE=${ZDOTDIR:-$HOME}/.zhistory
unsetopt SHARE_HISTORY             # Share history between all sessions.

# Install fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Disable the virtualenv prompt.
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENVWRAPPER_WORKON_CD=0
# source `which virtualenvwrapper.sh`
source "$HOME/bin/z"

# Rename autoenv file to .autoenv
export AUTOENV_FILE_ENTER='.autoenv'

# Start antigen and use more plugins
source "$HOME/.antigen/antigen.zsh"
antigen bundle Tarrasch/zsh-autoenv
antigen bundle akoenig/gulp.plugin.zsh
antigen bundle zsh-users/zsh-completions
antigen bundle unixorn/tumult.plugin.zsh
antigen bundle srijanshetty/zsh-pip-completion
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle greymd/docker-zsh-completion
antigen bundle MichaelAquilina/zsh-you-should-use
# antigen bundle dubizzle/awsshutils
antigen bundle changyuheng/fz
antigen bundle zsh-users/zsh-completions
# antigen bundle dbz/kube-aliases
antigen apply


[[ -f "$HOME/.aliases" ]] && source $HOME/.aliases
[[ -f "$HOME/.functions" ]] && source $HOME/.functions
[[ -f "$HOME/.extra" ]] && source $HOME/.extra
# autoload -U compinit && compinit
