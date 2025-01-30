# Environment variables (equivalent to .zshenv and .zprofile)
$env.CLICOLOR = 1
$env.LSCOLORS = "gxBxhxDxfxhxhxhxhxcxcx"
$env.TERM = "xterm-256color"
$env.LANG = "en_US.UTF-8"
$env.LC_ALL = "en_US.UTF-8"

# Editor configuration
$env.EDITOR = "vi"
$env.VISUAL = "vi"
$env.PAGER = "less"

# Path configuration
$env.PATH = (
  $env.PATH
  | split row (char esep)
  | prepend [
      $"($env.HOME)/bin",
      $"($env.HOME)/.local/bin",
      "/usr/local/bin",
      "/usr/local/sbin",
      "/usr/local/share/npm/bin",
      "/usr/bin",
      "/usr/sbin",
      "/bin",
      "/sbin"
    ]
)

# Less configuration
$env.LESS = "-g -i -M -R -S -w -X -z-4"
$env.LESSOPEN = "| /usr/bin/env lesspipe %s 2>&-"
