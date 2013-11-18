export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export TERM="xterm-256color"

export MKL_NUM_THREADS=1

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export L1=~/Library/Enthought/Canopy_64bit/System
export L2=~/Library/Enthought/Canopy_64bit/User
export EDITOR='subl -w'


# Browser.
# --------
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Editors.
# --------
export EDITOR='/usr/local/bin/subl -w'
export VISUAL='/usr/local/bin/subl -w'
export PAGER='less'

# Most used directorys
# --------------------
hash -d venv=~/Projects/venvs/
hash -d erc=~/Enthought/src/
hash -d proj=~/Projects/

# Language.
# ---------
if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

# Less.
# -----
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# Paths.
# ------
typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Commonly used directories.
as="$HOME/Library/Application Support"

# Set the the list of directories that cd searches.
cdpath=(
  $cdpath
)

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/Applications/Android Studio.app/sdk/tools:${PATH}"
export PATH="/Applications/Android Studio.app/sdk/platform-tools:${PATH}"
export PATH="${PATH}:/usr/local/share/elasticsearch/bin"
export PATH="${PATH}:/usr/local/sbin"
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/texbin:/Library/Frameworks/EPD64.framework/Versions/Current/bin:/Library/Frameworks/Python.framework/Versions/Current/bin:/usr/local/mysql/bin:/usr/local/sbin"
export PATH="/Library/Frameworks/EPD64.framework/Versions/Current/bin:${PATH}"

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

# Temporary Files.
if [[ -d "$TMPDIR" ]]; then
  export TMPPREFIX="${TMPDIR%/}/zsh"
  if [[ ! -d "$TMPPREFIX" ]]; then
    mkdir -p "$TMPPREFIX"
  fi
fi

# Settings for virtualenvwrapper
export WORKON_HOME=$HOME/Projects/venvs
export VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/EPD64.framework/Versions/Current/bin/python
source /usr/local/bin/virtualenvwrapper.sh


[[-f "source $HOME/.aliases"]] && source $HOME/.aliases
[[-f "source $HOME/.functions"]] && source $HOME/.functions
[[-f "source $HOME/.extra"]] && source $HOME/.extra
