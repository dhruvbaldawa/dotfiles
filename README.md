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

For GPG agent caching and Keychain integration, see [docs/gpg_setup.md](docs/gpg_setup.md).

## Quick install (existing setup)

If Homebrew and gopass are already configured:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dhruvbaldawa
```

## Local development

To run the bootstrap script locally:

```bash
bun run scripts/bootstrap.ts
```

## What's included

- **Shell**: zsh with prezto, starship prompt
- **Editors**: vim, VS Code settings
- **Git**: config with delta diff, diff-so-fancy
- **Secrets**: gopass integration with GPG, 7-day passphrase caching
- **Tools**: fzf, ripgrep, zoxide, jq, and more

## Configuration

On first run, chezmoi prompts for a secrets profile (`personal` or `work`) to load the appropriate configuration.

## Machine-local config: `~/.extra`

`~/.zshrc` sources `~/.extra` last, if it exists. It holds machine-specific config
(work PATHs, per-machine secrets, tool init added by installers) and is deliberately
**not managed by chezmoi** — create it by hand on each machine.

Rules for `~/.extra`:

- No literal secrets — reference gopass instead.
- No synchronous `gopass show` or `eval "$(cmd)"` at startup. Each gopass call costs
  ~0.5–1s per shell. Batch secret exports behind the tmpfs cache pattern used in
  `tools.sh` (7-day TTL, `umask 077`, atomic `command mv -f` write, only cache
  when every lookup succeeds), or use `__cache_eval` from `.zshrc` for tool inits.
