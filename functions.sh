# Create a new directory and enter it
function mkcd() {
    mkdir -p "$@" && cd "$@"
}

function m() {
    export GEN_MSG="$@"
}

function cm() {
    unset GEN_MSG;
}

# JIRA ticket in the commit message
function jgcm() {
    git commit -m "${GEN_MSG}: $@"
}

# Create a data URL from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}


function runupdate(){
    brew update && \
    brew outdated -q --formula | xargs brew upgrade
    zprezto-update
}
