# Claude Code MCPs
export FIRECRAWL_API_KEY="$(gopass show creds/firecrawl-api-key)"
export OTEL_BEARER_TOKEN="$(gopass show creds/otel-bearer-token)"
export MCP_PROXY_HOST="https://mcp.dhruv.cc"
export MCP_PROXY_AUTH="$(gopass show creds/mcp-proxy-auth)"
export BRAVE_API_KEY="(gopass show creds/brave-api-key)"

export APPRISE_URLS="$(gopass show creds/apprise-urls)"

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
