# GPG Agent Setup

This dotfiles repo configures GPG agent to cache passphrases for 7 days with platform-specific pinentry programs.

## Dependencies

### macOS (via Homebrew)

Already included in `Brewfile`:

```bash
brew install gnupg pinentry-mac
```

### Linux (Debian/Ubuntu)

```bash
sudo apt install gnupg pinentry-curses
```

### Linux (RHEL/Fedora)

```bash
sudo dnf install gnupg2 pinentry-curses
```

## Configuration

After running `chezmoi apply`, the following files are created:

| File | Purpose |
|------|---------|
| `~/.gnupg/gpg-agent.conf` | Agent settings, cache TTL, pinentry program |
| `~/.gnupg/gpg.conf` | GPG defaults and agent integration |

### Cache Settings

- **default-cache-ttl**: 7 days (604800 seconds) - resets on each use
- **max-cache-ttl**: 7 days (604800 seconds) - absolute maximum

### Platform-Specific Pinentry

| Platform | Pinentry | Location |
|----------|----------|----------|
| macOS (Apple Silicon) | pinentry-mac | `/opt/homebrew/bin/pinentry-mac` |
| macOS (Intel) | pinentry-mac | `/usr/local/bin/pinentry-mac` |
| Linux | pinentry-curses | `/usr/bin/pinentry-curses` |

## macOS Keychain Integration

`pinentry-mac` can store your GPG passphrase in macOS Keychain for persistent storage across reboots.

### Enable Keychain Storage

```bash
# Enable Keychain integration
defaults write org.gpgtools.common UseKeychain -bool yes
defaults write org.gpgtools.pinentry-mac DisableKeychain -bool no

# Reload the agent
gpgconf --kill gpg-agent
```

When prompted for your passphrase, check **"Save in Keychain"** to store it permanently.

### Disable Keychain Storage

If you prefer not to store the passphrase in Keychain:

```bash
defaults write org.gpgtools.pinentry-mac DisableKeychain -bool yes
```

## Applying Changes

After modifying GPG configuration:

```bash
# Reload the agent (picks up config changes)
gpg-connect-agent reloadagent /bye

# Or kill the agent (restarts on next use)
gpgconf --kill gpg-agent
```

## Troubleshooting

### "No pinentry" error

Verify pinentry is installed and the path is correct:

```bash
# macOS
which pinentry-mac

# Linux
which pinentry-curses
```

Update `~/.gnupg/gpg-agent.conf` if the path differs.

### Agent not caching passphrase

1. Check agent is running: `gpg-connect-agent /bye`
2. Verify config is loaded: `gpgconf --list-options gpg-agent | grep cache-ttl`
3. Restart agent: `gpgconf --kill gpg-agent`

### macOS Keychain not prompting to save

```bash
defaults write org.gpgtools.pinentry-mac DisableKeychain -bool no
gpgconf --kill gpg-agent
```

### SSH/tmux issues on Linux

The config enables `allow-loopback-pinentry` and `pinentry-mode loopback` for headless environments. If you still have issues:

```bash
export GPG_TTY=$(tty)
```

Add this to your `~/.zshrc` or `~/.bashrc`.
