# dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io/).

## Bootstrap a new machine

Run the bootstrap script to set up a fresh macOS instance:

```bash
curl -fsSL https://raw.githubusercontent.com/dhruvbaldawa/dotfiles/main/bootstrap.sh | bash
```

This launches an interactive setup that lets you choose:

- **Packages to install:**
  - Core CLI tools (git, fzf, ripgrep, starship, etc.)
  - Desktop applications (VS Code, iTerm2, Arc, Obsidian, etc.)
  - Work tools (Kubernetes, AWS, Helm, 1Password)

- **Setup steps:**
  - GitHub CLI authentication
  - Secrets store (gopass) setup
  - Dotfiles application (chezmoi)

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

## Local development

To run the bootstrap script locally:

```bash
cd scripts
bun install
bun run bootstrap
```

## What's included

- **Shell**: zsh with prezto, starship prompt, atuin history
- **Editors**: vim, VS Code settings
- **Git**: config with delta diff, diff-so-fancy
- **Secrets**: gopass integration with GPG
- **Tools**: fzf, ripgrep, zoxide, jq, and more

## Configuration

On first run, chezmoi prompts for a secrets profile (`personal` or `work`) to load the appropriate configuration.
