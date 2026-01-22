# Modern tmux Configuration - Testing Guide

This guide walks you through testing every feature in your modernized tmux setup. Work through each section to verify everything is configured correctly.

---

## Prerequisites Checklist

Before testing, verify all dependencies are installed:

```bash
# Check each tool
tmux -V          # Should be 3.2+ for popup support
fzf --version    # Fuzzy finder
zoxide --version # Smart cd
sesh --version   # Session manager
lazygit --version # Git TUI (optional)
```

**Check TPM is installed:**

```bash
ls ~/.tmux/plugins/tpm
```

**Check plugins are installed:**

```bash
ls ~/.tmux/plugins/
# Should see: tpm, tmux-sensible, catppuccin, tmux-yank, etc.
```

If plugins are missing, start tmux and press `prefix + I` (Ctrl-b, then Shift-i).

---

## Test 1: Basic Session & Config

### 1.1 Start tmux

```bash
tmux new -s test-session
```

**Expected:** New tmux session starts with Catppuccin theme visible in status bar.

### 1.2 Reload Configuration

```
prefix + r
```

**Expected:** Message "Config reloaded!" appears briefly.

### 1.3 Check Mouse Support

- Try clicking on different panes
- Try scrolling with mouse wheel
- Try dragging pane borders to resize

**Expected:** All mouse interactions work smoothly.

---

## Test 2: Pane Management

### 2.1 Splitting Panes

| Test | Binding | Expected Result |
|------|---------|-----------------|
| Horizontal split | `prefix + \|` | New pane appears to the right |
| Horizontal split (alt) | `prefix + \` | Same as above (no shift needed) |
| Vertical split | `prefix + -` | New pane appears below |

```
# After splits, you should see something like:
┌─────────┬─────────┐
│         │         │
│  pane1  │  pane2  │
│         │         │
├─────────┴─────────┤
│      pane3        │
└───────────────────┘
```

### 2.2 Pane Navigation

| Test | Binding | Expected Result |
|------|---------|-----------------|
| Move left | `prefix + h` | Focus moves to left pane |
| Move down | `prefix + j` | Focus moves to pane below |
| Move up | `prefix + k` | Focus moves to pane above |
| Move right | `prefix + l` | Focus moves to right pane |
| Move left (no prefix) | `Alt + ←` | Focus moves left |
| Move right (no prefix) | `Alt + →` | Focus moves right |
| Move up (no prefix) | `Alt + ↑` | Focus moves up |
| Move down (no prefix) | `Alt + ↓` | Focus moves down |

**Test procedure:**

1. Create a 2x2 grid of panes
2. Try each navigation key
3. Verify the active pane border changes (should be lavender color)

### 2.3 Pane Resizing

| Test | Binding | Expected Result |
|------|---------|-----------------|
| Grow left | `prefix + H` | Active pane expands left |
| Grow down | `prefix + J` | Active pane expands down |
| Grow up | `prefix + K` | Active pane expands up |
| Grow right | `prefix + L` | Active pane expands right |

**Note:** These are repeatable - hold prefix, then tap H/J/K/L multiple times.

### 2.4 Pane Zoom (Fullscreen Toggle)

```
prefix + z
```

**Test procedure:**

1. Create multiple panes
2. Press `prefix + z` on one pane
3. **Expected:** Pane fills entire window
4. Press `prefix + z` again
5. **Expected:** Returns to original layout

### 2.5 Swap Panes

| Test | Binding | Expected Result |
|------|---------|-----------------|
| Swap with next | `prefix + >` | Current pane swaps with next |
| Swap with previous | `prefix + <` | Current pane swaps with previous |

### 2.6 Kill Pane

```
prefix + x
```

**Expected:** Pane closes immediately (no confirmation prompt).

### 2.7 Synchronize Panes

```
prefix + S
```

**Test procedure:**

1. Create 2+ panes
2. Press `prefix + S`
3. Type something
4. **Expected:** Text appears in ALL panes simultaneously
5. Press `prefix + S` again to disable

---

## Test 3: Window Management

### 3.1 Create New Window

```
prefix + c
```

**Expected:** New window created, numbered sequentially starting from 1.

### 3.2 Window Navigation

| Test | Binding | Expected Result |
|------|---------|-----------------|
| Go to window 1 | `Alt + 1` | Switches to window 1 |
| Go to window 2 | `Alt + 2` | Switches to window 2 |
| Previous window | `Shift + ←` | Goes to previous window |
| Next window | `Shift + →` | Goes to next window |

**Test procedure:**

1. Create 3 windows (`prefix + c` three times)
2. Use `Alt + 1`, `Alt + 2`, `Alt + 3` to jump between them
3. Use `Shift + Left/Right` to cycle through

### 3.3 Move Windows

| Test | Binding | Expected Result |
|------|---------|-----------------|
| Move window left | `prefix + Ctrl-h` | Window moves left in tab bar |
| Move window right | `prefix + Ctrl-l` | Window moves right in tab bar |

### 3.4 Break Pane to Window

```
prefix + b
```

**Test procedure:**

1. Create a split with 2 panes
2. Focus on one pane
3. Press `prefix + b`
4. **Expected:** Pane becomes its own window

---

## Test 4: Floating Popups (Zellij-style)

### 4.1 Quick Floating Terminal

```
Alt + f
```

**Expected:**

- 80% width/height popup appears over current window
- Opens in current directory
- Press `Ctrl-d` or `exit` to close

### 4.2 Persistent Scratch Terminal

```
Alt + g
```

**Expected:**

- Popup appears connected to "scratch" session
- Close popup (Ctrl-d on the popup's shell, or click outside)
- Open again with `Alt + g`
- **Previous state/history should persist!**

### 4.3 Lazygit Popup

```
prefix + g
```

**Expected:**

- Large popup (90%) opens with lazygit
- Only works in a git repository
- Press `q` to exit lazygit and close popup

### 4.4 Htop Popup

```
prefix + G
```

**Expected:**

- System monitor opens in popup
- Press `q` to close

---

## Test 5: Session Management

### 5.1 Fuzzy Session Picker (sesh)

```
prefix + T
```

**Expected:**

- Popup appears with fzf interface
- Shows existing tmux sessions
- Shows zoxide directories (recent folders)

**Test the keybindings inside the picker:**

| Key | Action |
|-----|--------|
| `Ctrl-a` | Show all (sessions + zoxide) |
| `Ctrl-t` | Show only tmux sessions |
| `Ctrl-x` | Show only zoxide directories |
| `Ctrl-d` | Kill selected session |
| `Enter` | Connect to selection |
| `Esc` | Cancel |

**Test procedure:**

1. Create a few sessions: `tmux new -s project1 -d` and `tmux new -s project2 -d`
2. cd into a few directories to populate zoxide
3. Press `prefix + T`
4. Try each filter (Ctrl-a, Ctrl-t, Ctrl-x)
5. Select a session and press Enter

### 5.2 Simple Session Switcher

```
prefix + s
```

**Expected:** Simpler fzf popup showing only existing sessions.

### 5.3 Create Named Session

```
prefix + N
```

**Expected:** Prompt appears asking for session name. Enter a name and press Enter.

---

## Test 6: Copy Mode (Vim-style)

### 6.1 Enter Copy Mode

```
prefix + v
```

**Expected:**

- Enters copy mode
- Can navigate with vim keys (h/j/k/l)
- Status shows "[copy mode]" or similar

### 6.2 Selection and Yank

**Test procedure:**

1. Generate some text: `ls -la` or `cat /etc/passwd`
2. Enter copy mode: `prefix + v`
3. Navigate to start of text
4. Press `v` to start selection
5. Move to expand selection
6. Press `y` to yank (copy)
7. **Expected:** Exits copy mode, text is in clipboard
8. Paste with `prefix + ]` or system paste

### 6.3 Rectangle Selection

**Test procedure:**

1. Enter copy mode: `prefix + v`
2. Press `Ctrl-v` for rectangle/block selection
3. Select a rectangular area
4. Press `y` to yank

### 6.4 Mouse Selection

**Test procedure:**

1. Click and drag to select text
2. **Expected:** Text is automatically copied when you release mouse

---

## Test 7: Quick Actions Menu

```
prefix + m
```

**Expected:** Popup menu appears with options:

- Horizontal Split (h)
- Vertical Split (v)
- New Window (n)
- Kill Window (X)
- Rename Window (r)
- Rename Session (R)
- Sync Panes (s)
- Reload Config (c)

**Test:** Select each option using the letter key or arrow keys + Enter.

---

## Test 8: Theme Verification

### 8.1 Color Check

The Catppuccin Mocha theme should show:

- **Status bar:** Dark background with pastel accents
- **Active pane border:** Lavender/purple
- **Inactive pane border:** Subtle gray
- **Window tabs:** Rounded style with current window highlighted

### 8.2 Change Theme Flavor

Edit `~/.tmux.conf` and change:

```bash
set -g @catppuccin_flavor 'mocha'  # Try: latte, frappe, macchiato
```

Then reload: `prefix + r`

| Flavor | Description |
|--------|-------------|
| `latte` | Light theme |
| `frappe` | Medium dark |
| `macchiato` | Darker |
| `mocha` | Darkest (default) |

---

## Test 9: Session Persistence (Resurrect)

### 9.1 Save Session

```
prefix + Ctrl-s
```

**Expected:** Message "Saving..." then "Saved!"

### 9.2 Restore Session

```
prefix + Ctrl-r
```

**Test procedure:**

1. Create a complex layout (multiple windows, panes)
2. Run some commands in different panes
3. Save: `prefix + Ctrl-s`
4. Kill tmux server: `tmux kill-server`
5. Start tmux: `tmux`
6. Restore: `prefix + Ctrl-r`
7. **Expected:** Layout and pane contents restored

### 9.3 Auto-Restore (Continuum)

If configured, tmux should auto-restore last session on start.

---

## Test 10: Vim-Tmux Navigator

> Only works if you use Neovim/Vim with the matching plugin installed.

### 10.1 Seamless Navigation

**Test procedure:**

1. Open vim/neovim in one pane
2. Create splits in both vim and tmux
3. Use `Ctrl-h/j/k/l` to navigate
4. **Expected:** Seamlessly moves between vim splits AND tmux panes

---

## Troubleshooting

### Plugins not loading

```bash
# Reinstall plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Or clean and reinstall
~/.tmux/plugins/tpm/bin/clean_plugins
prefix + I
```

### Theme not applying

```bash
# Make sure catppuccin is loaded BEFORE status-right is set
# Check plugin order in ~/.tmux.conf
```

### Popups not working

```bash
# Check tmux version (need 3.2+)
tmux -V

# If old version on Linux:
sudo apt install tmux  # might need PPA for newer version
# Or build from source
```

### sesh not found

```bash
# Check if sesh is in PATH
which sesh

# If using Go install, add to PATH:
export PATH="$PATH:$(go env GOPATH)/bin"
```

### Keybindings conflicting with terminal

Some terminals capture Alt keys. Solutions:

- iTerm2: Preferences → Profiles → Keys → Left Option Key → "Esc+"
- Alacritty: Should work by default
- Kitty: Should work by default

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────┐
│                    MODERN TMUX CHEATSHEET                   │
├─────────────────────────────────────────────────────────────┤
│  SESSIONS                    │  PANES                       │
│  prefix + T  → sesh picker   │  prefix + |  → split horiz   │
│  prefix + s  → quick switch  │  prefix + -  → split vert    │
│  prefix + N  → new named     │  prefix + hjkl → navigate    │
│                              │  prefix + HJKL → resize      │
├──────────────────────────────┼──────────────────────────────┤
│  WINDOWS                     │  POPUPS                      │
│  prefix + c  → new window    │  Alt + f  → floating term    │
│  Alt + 1-9   → go to window  │  Alt + g  → scratch term     │
│  Shift + ←/→ → prev/next     │  prefix + g → lazygit        │
├──────────────────────────────┼──────────────────────────────┤
│  COPY MODE                   │  OTHER                       │
│  prefix + v  → enter         │  prefix + r  → reload conf   │
│  v          → start select   │  prefix + z  → zoom pane     │
│  y          → yank           │  prefix + m  → menu          │
│  Ctrl-v     → rectangle      │  prefix + S  → sync panes    │
└─────────────────────────────────────────────────────────────┘
```

---

## Success Criteria

You've successfully configured modern tmux if:

- [ ] Catppuccin theme is visible with rounded window tabs
- [ ] All pane splits and navigation work
- [ ] `Alt + f` opens a floating popup
- [ ] `prefix + T` opens the sesh session picker
- [ ] Copy mode works with vim bindings
- [ ] Mouse scrolling and selection work
- [ ] `prefix + m` shows the quick actions menu
- [ ] Sessions persist across tmux restarts (resurrect)

🎉 **Congratulations!** Your tmux is now modernized with Zellij-like features!
