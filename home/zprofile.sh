export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export TERM="xterm-256color"

export MKL_NUM_THREADS=1

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Browser.
# --------
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Editors.
# --------
export EDITOR='vi'
export VISUAL='vi'
export PAGER='less'

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
  /usr/local/opt/coreutils/libexec/gnuman
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

fpath=(
  /usr/local/share/zsh/site-functions
  $fpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/{bin,sbin}
  /usr/local/lib/python2.7/site-packages
  /usr/local/share/npm/bin
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

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
