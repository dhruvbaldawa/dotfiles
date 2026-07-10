# Secrets: decrypt gopass bundle to tmpfs cache (7-day TTL), source on hit.
# Cold start (cache absent/expired): ~1.3s. Warm hit: <5ms.
# Run "shell-env build" once to populate; "eval $(shell-env reload)" to refresh in-session.
() {
  local cache="${TMPDIR:-/tmp}/zsh-secrets-${UID}"
  local now=0 mtime=0
  (( now = EPOCHSECONDS ))
  local -A _cs
  zstat -H _cs "$cache" 2>/dev/null && mtime=${_cs[mtime]}
  if [[ "$OSTYPE" == darwin* ]]; then
    # ~/.run isn't tmpfs on macOS, so a hard restart leaves the gopass
    # age-agent socket file behind after its process is gone. The agent then
    # fails to rebind on it ("address already in use") until it's cleared.
    # Any socket older than boot is guaranteed stale.
    local sock="$HOME/.run/gopass/gopass-age-agent.sock" sock_mtime=0 boot_time=0
    local -A _sk
    zstat -H _sk "$sock" 2>/dev/null && sock_mtime=${_sk[mtime]}
    boot_time=$(sysctl -n kern.boottime 2>/dev/null | sed -n 's/.*{ sec = \([0-9]*\).*/\1/p')
    (( sock_mtime > 0 && boot_time > 0 && sock_mtime < boot_time )) && rm -f "$sock"
  fi
  if (( now - mtime >= 604800 )); then
    # Subshell: umask change must not leak into the interactive session.
    # Atomic write: write to .tmp then rename so a failed decrypt never leaves
    # a fresh-mtime empty file that suppresses retries for the whole TTL.
    # `command mv -f`: bypass any interactive mv alias (safe-ops mv -i) so a
    # cache refresh never blocks the shell on an overwrite prompt.
    (umask 077; gopass show -f creds/shell-env >"${cache}.tmp" 2>/dev/null) \
      && command mv -f "${cache}.tmp" "$cache" \
      || command rm -f "${cache}.tmp"
  fi
  [[ -s "$cache" ]] && source "$cache"
}

# Claude Code MCPs
export MCP_PROXY_HOST="https://mcp.dhruv.cc"

# Claude Code OTEL telemetry
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export CLAUDE_CODE_NO_FLICKER=1
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf
export OTEL_EXPORTER_OTLP_ENDPOINT=https://otel.dhruv.cc
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Bearer ${OTEL_BEARER_TOKEN}"
export OTEL_RESOURCE_ATTRIBUTES=plan=claude-max
export OTEL_METRIC_EXPORT_INTERVAL=10000
export OTEL_LOGS_EXPORT_INTERVAL=5000

# Opencode
export OPENCODE_ENABLE_TELEMETRY=1
export OPENCODE_OTLP_ENDPOINT="https://otel.dhruv.cc"
export OPENCODE_OTLP_HEADERS="Authorization=Bearer ${OTEL_BEARER_TOKEN}"
export OPENCODE_OTLP_PROTOCOL=http/protobuf
export OPENCODE_OTLP_METRICS_INTERVAL=5000

# Codex
export OTEL_EXPORTER_OTLP_AUTHORIZATION="Bearer ${OTEL_BEARER_TOKEN}"

# RTK
export RTK_TELEMETRY_DISABLED=1

# opencode OTEL telemetry (separate namespace from Claude Code)
export OPENCODE_ENABLE_TELEMETRY=1
export OPENCODE_OTLP_ENDPOINT="${OTEL_EXPORTER_OTLP_ENDPOINT}"
export OPENCODE_OTLP_PROTOCOL="${OTEL_EXPORTER_OTLP_PROTOCOL}"
export OPENCODE_OTLP_HEADERS="${OTEL_EXPORTER_OTLP_HEADERS}"
export OPENCODE_RESOURCE_ATTRIBUTES="service.name=opencode,service.namespace=cli-agents,plan=opencode-go"
