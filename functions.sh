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

# Update ccconfigs, chezmoi, and gopass if on main branch
function syncconfigs() {
    local current_dir="$PWD"
    local status_ccconfigs status_chezmoi status_gopass

    echo "Syncing configurations...\n"

    # Update ccconfigs
    printf "  ccconfigs  "
    if [[ -d "$HOME/Code/ccconfigs" ]]; then
        cd "$HOME/Code/ccconfigs"
        if [[ "$(git rev-parse --abbrev-ref HEAD)" == "main" ]]; then
            if git pull -q 2>/dev/null; then
                status_ccconfigs="✓ updated"
            else
                status_ccconfigs="✗ pull failed"
            fi
        else
            status_ccconfigs="- skipped (not on main)"
        fi
    else
        status_ccconfigs="- skipped (not found)"
    fi
    echo "$status_ccconfigs"

    # Update chezmoi
    printf "  chezmoi    "
    if command -v chezmoi &>/dev/null; then
        if [[ "$(chezmoi git -- rev-parse --abbrev-ref HEAD 2>/dev/null)" == "main" ]]; then
            if chezmoi git pull -- -q 2>/dev/null; then
                status_chezmoi="✓ updated"
                chezmoi update --interactive
            else
                status_chezmoi="✗ pull failed"
            fi
        else
            status_chezmoi="- skipped (not on main)"
        fi
    else
        status_chezmoi="- skipped (not found)"
    fi
    echo "$status_chezmoi"

    # Update gopass
    printf "  gopass     "
    if command -v gopass &>/dev/null; then
        if gopass ls &>/dev/null; then
            status_gopass="✓ synced"
        else
            status_gopass="✗ sync failed"
        fi
    else
        status_gopass="- skipped (not found)"
    fi
    echo "$status_gopass"

    echo "\nDone!"
    cd "$current_dir"
}
