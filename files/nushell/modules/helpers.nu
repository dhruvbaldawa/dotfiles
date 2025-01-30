# Aliases (equivalent to .aliases)
alias ls = ls -l
alias la = ls -la
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ~ = cd ~
alias - = cd -
alias pd = cd -

# Git-specific aliases
alias gc = git commit
alias gs = git status
alias grv = git remote -v show
alias gd = git diff
alias gds = git diff --staged
alias gcm = git commit -m
alias grh = git reset --hard
alias gst = git stash
alias gco = git checkout
alias gb = git branch
alias gia = git add
alias gap = git add -p
alias cpr = gh pr create
alias gth = git town-hack
alias gts = git-town sync
alias ghya = git push
alias ghyauf = git push -uf origin (git-branch-current)
alias dya = git pull
alias gfo = git fetch origin
alias gpom = git pull origin master
alias gpu = git push -u

# IP addresses
alias ip = dig +short myip.opendns.com @resolver1.opendns.com
alias localip = ipconfig getifaddr en1
def ips [] {
    ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)'
}

# OS X has no `md5sum`, so use `md5` as a fallback
if (try { which md5sum | empty? } catch { true }) { alias md5sum = md5 }

# OS X has no `sha1sum`, so use `shasum` as a fallback
if (try { which sha1sum | empty? } catch { true }) { alias sha1sum = shasum }


# Show/hide hidden files in Finder
def showfiles [] {
    bash -c "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
}
def hidefiles [] {
    bash -c "defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
}

# Hide/show all desktop icons (useful when presenting)
def hidedesktop [] {
    defaults write com.apple.finder CreateDesktop -bool false and killall Finder
}
def showdesktop [] {
    defaults write com.apple.finder CreateDesktop -bool true and killall Finder
}

def reload [] {
    exec $env.SHELL -l
}

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

def uxt [num: string] {
    ^date --date $"@($num)"
}

alias afk = /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend

# Returns a record of changed env variables after running a non-nushell script's contents (passed via stdin), e.g. a bash script you want to "source"
def capture-foreign-env [
    --shell (-s): string = /bin/sh
    # The shell to run the script in
    # (has to support '-c' argument and POSIX 'env', 'echo', 'eval' commands)
    --arguments (-a): list<string> = []
    # Additional command line arguments to pass to the foreign shell
] {
    let script_contents = $in;
    let env_out = with-env { SCRIPT_TO_SOURCE: $script_contents } {
        ^$shell ...$arguments -c `
        env
        echo '<ENV_CAPTURE_EVAL_FENCE>'
        eval "$SCRIPT_TO_SOURCE"
        echo '<ENV_CAPTURE_EVAL_FENCE>'
        env -u _ -u _AST_FEATURES -u SHLVL` # Filter out known changing variables
    }
    | split row '<ENV_CAPTURE_EVAL_FENCE>'
    | {
        before: ($in | first | str trim | lines)
        after: ($in | last | str trim | lines)
    }

    # Unfortunate Assumption:
    # No changed env var contains newlines (not cleanly parseable)
    $env_out.after
    | where { |line| $line not-in $env_out.before } # Only get changed lines
    | parse "{key}={value}"
    | transpose --header-row --as-record
}
