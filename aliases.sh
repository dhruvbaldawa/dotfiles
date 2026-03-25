# Easier navigation: .., ..., ~ and -
# unalias rm
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"
alias pd="popd"

# programs
alias safari="open -a safari"
alias firefox="open -a firefox"
alias chrome="open -a google\ chrome"
alias f='open -a Finder'

# be nice
alias please=sudo

# Modern CLI replacements
alias ls='eza'
alias l='eza -l'
alias la='eza -la'
alias lsd='eza -lD'
alias lt='eza --tree --level=2'
alias cat='bat --paging=never'
alias c='bat'

alias grep='grep --color=auto'

# GIT STUFF
alias lg='lazygit'

# Undo a `git push`
alias undopush="git push -f origin HEAD^:main"

# Git-specific aliases
alias gc="git commit"
alias gs="git status"
alias grv="git remote -v show"
alias gd='git diff'
alias gds='git diff --staged'
alias gcm='git commit -m'
alias grh='git reset --hard'
alias gst='git stash'
#alias gco='git checkout'
#alias gb='git branch'
# alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{\$1=\$2=\"\"; print \$0}' | \
           perl -pe 's/^[ \t]*//' | sed 's/ /\\\\ /g' | xargs git rm"
alias gap='git add -p'
alias cpr='gh pr create'
alias gth='git town-hack'
alias gts='git-town sync'

# usable git aliases
alias ghya='git push'
alias ghyauf='git push -uf origin $(git-branch-current)'
alias dya='git pull'
alias kasakai='git status'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time command cat && date'

# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Recursively delete `*.pyc` files
alias pyclean='find . -name "*.pyc" | xargs -I {} rm -v "{}"'
alias pipfg='pip freeze | grep -i '

# Shortcuts
alias v="vim"

# File size
alias fs="stat -f \"%z bytes\""

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# Empty the Trash on all mounted volumes and the main HDD
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote_plus(sys.argv[1]))"'

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"
alias bell="tput bel"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Volume control
alias stfu="osascript -e ‘set volume output muted true’"
alias pumpitup="osascript -e ‘set volume 10’"

# Docker cleanup
alias dprune='docker system prune -af'
alias drmi='docker images -q --filter "dangling=true" | xargs docker rmi'
alias drmc='docker ps -aq --filter "status=exited" | xargs docker rm'

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

alias gfo="git fetch origin"
alias gpom="git pull origin main"
alias gpu="git push -u"
#alias uxt="date --date=@"

function uxt() {
    date --date="@$@"
}
