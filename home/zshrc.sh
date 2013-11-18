#!/usr/bin/env zsh
ZSH=$HOME/.oh-my-zsh
. "$ZSH/plugins/z/z.sh"
ZSH_THEME="amuse"
# Lines configured by zsh-newuser-install

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors

fpath=($ZSH/lib $fpath)
autoload -U $ZSH/lib/*(:t)

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

VIRTUAL_ENV_DISABLE_PROMPT=True

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# zstyle ':completion:*:*:git:*' script $ZSH/plugins/gitfast/git-completion.zsh

plugins=(git brew celery coffee git-extras history history-substring-search npm osx pip python themes tmux virtualenv virtualenvwrapper z)

# this should be the last line
source $ZSH/oh-my-zsh.sh

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases
setopt no_share_history
setopt auto_pushd
setopt pushd_silent
setopt hist_expire_dups_first
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt APPEND_HISTORY # adds history
setopt hist_ignore_dups # don't record dupes in history
setopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# zstyle :compinstall filename '/Users/dhruv/.zshrc'

# matches case insensitive for lowercase
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
# zstyle ':completion:*' insert-tab pending
