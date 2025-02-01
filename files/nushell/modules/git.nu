# Git
alias g = git

def git-branch-current [] {
  git branch --show-current | str trim
}

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

# Branch (b)
alias gb = git branch
alias gba = git branch --all --verbose
alias gbc = git checkout -b
alias gbd = git branch --delete
alias gbD = git branch --delete --force
alias gbl = git branch --verbose
alias gbL = git branch --all --verbose
alias gbm = git branch --move
alias gbM = git branch --move --force
alias gbr = git branch --move
alias gbR = git branch --move --force
alias gbs = git show-branch
alias gbS = git show-branch --all
alias gbv = git branch --verbose
alias gbV = git branch --verbose --verbose
alias gbx = git branch --delete
alias gbX = git branch --delete --force

# Commit (c)
alias gc = git commit --verbose
alias gcS = git commit --verbose --gpg-sign
alias gca = git commit --verbose --all
alias gcaS = git commit --verbose --all --gpg-sign
alias gcm = git commit --message
alias gcmS = git commit --message --gpg-sign
alias gcam = git commit --all --message
alias gco = git checkout
alias gcO = git checkout --patch
alias gcf = git commit --amend --reuse-message HEAD
alias gcfS = git commit --amend --reuse-message HEAD --gpg-sign
alias gcF = git commit --verbose --amend
alias gcFS = git commit --verbose --amend --gpg-sign
alias gcp = git cherry-pick --ff
alias gcP = git cherry-pick --no-commit
alias gcr = git revert
alias gcR = git reset "HEAD^"
alias gcs = git show
alias gcsS = git show --pretty=short --show-signature
alias gcl = git-commit-lost
alias gcy = git cherry --verbose --abbrev
alias gcY = git cherry --verbose

# Data (d)
alias gd = git ls-files
alias gdc = git ls-files --cached
alias gdx = git ls-files --deleted
alias gdm = git ls-files --modified
alias gdu = git ls-files --other --exclude-standard
alias gdk = git ls-files --killed
alias gdi = git status --porcelain --short --ignored | sed -n "s/^!! //p"

# Fetch (f)
alias gf = git fetch
alias gfa = git fetch --all

# Index (i)
alias gia = git add
alias giA = git add --patch
alias giu = git add --update
alias gid = git diff --no-ext-diff --cached
alias giD = git diff --no-ext-diff --cached --word-diff
alias gii = git update-index --assume-unchanged
alias giI = git update-index --no-assume-unchanged
alias gir = git reset
alias giR = git reset --patch
alias gix = git rm -r --cached
alias giX = git rm -r --force --cached

# Log (l)
alias gl = git log --topo-order --pretty=format:"$_git_log_medium_format"
alias gls = git log --topo-order --stat --pretty=format:"$_git_log_medium_format"
alias gld = git log --topo-order --stat --patch --full-diff --pretty=format:"$_git_log_medium_format"
alias glo = git log --topo-order --pretty=format:"$_git_log_oneline_format"
alias glg = git log --topo-order --graph --pretty=format:"$_git_log_oneline_format"
alias glb = git log --topo-order --pretty=format:"$_git_log_brief_format"
alias glc = git shortlog --summary --numbered
alias glS = git log --show-signature

# Merge (m)
alias gm = git merge
alias gmC = git merge --no-commit
alias gmF = git merge --no-ff
alias gma = git merge --abort
alias gmt = git mergetool

# Rebase (r)
alias gr = git rebase
alias gra = git rebase --abort
alias grc = git rebase --continue
alias gri = git rebase --interactive
alias grs = git rebase --skip

# Working Copy (w)
alias gws = git status --ignore-submodules=$_git_status_ignore_submodules --short
alias gwS = git status --ignore-submodules=$_git_status_ignore_submodules
alias gwd = git diff --no-ext-diff
alias gwD = git diff --no-ext-diff --word-diff
alias gwr = git reset --soft
alias gwR = git reset --hard
alias gwc = git clean --dry-run
alias gwC = git clean --force
alias gwx = git rm -r
alias gwX = git rm -r --force
