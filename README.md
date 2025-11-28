# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io/).

## Bootstrap a new machine

Run the bootstrap script to set up a fresh macOS instance:

```bash
curl -fsSL https://raw.githubusercontent.com/dhruvbaldawa/dotfiles/main/bootstrap.sh | bash
```

This will:

1. Install Homebrew
2. Install packages from Brewfile (CLI tools, casks)
3. Authenticate with GitHub CLI
4. Clone secrets store with gopass
5. Prompt for GPG key setup
6. Initialize and apply chezmoi

### Manual GPG setup

During bootstrap, you'll need to import your GPG key on the new machine:

```bash
gpg --import < keyfile
gopass sync
```

## Quick install (existing setup)

If Homebrew and gopass are already configured:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dhruvbaldawa
```

## What's included

- **Shell**: zsh with prezto, starship prompt, atuin history
- **Editors**: vim, VS Code settings
- **Git**: config with delta diff, diff-so-fancy
- **Secrets**: gopass integration with GPG
- **Tools**: fzf, ripgrep, zoxide, jq, and more

## Configuration

On first run, chezmoi prompts for a secrets profile (`personal` or `work`) to load the appropriate configuration.