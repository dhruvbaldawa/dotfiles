# Disable startup banner for cleaner experience [2][4]
$env.config = {
  show_banner: false
  buffer_editor: "code -w"
  table: {
    mode: rounded
    index_mode: auto
    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
    }
  }
  history: {
    max_size: 9999999
    file_format: "sqlite"  # Better performance than plaintext [4]
    isolation: true
    sync_on_enter: true
  }
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "prefix"
  }
  keybindings: [
    {
      name: fzf_file_picker
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: executehostcommand cmd: "fzf-file-picker" }
    }
  ]
}

# Prompt configuration
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { || starship prompt }
$env.PROMPT_COMMAND_RIGHT = { || starship prompt --right }

$env.PROMPT_INDICATOR = "⭐️ "
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Source other configuration files
source ($nu.default-config-dir | path join modules helpers.nu)
source ($nu.default-config-dir | path join modules tools.nu)
if ($nu.default-config-dir | path join modules local.nu | path exists ) {
    source ($nu.default-config-dir | path join modules local.nu)
}
