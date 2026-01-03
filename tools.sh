# Claude Code MCPs
export FIRECRAWL_API_KEY="$(gopass show creds/firecrawl-api-key)"
export PERPLEXITY_API_KEY="$(gopass show creds/perplexity-api-key)"
export PARALLEL_API_KEY="$(gopass show creds/parallel-api-key)"
export OTEL_BEARER_TOKEN="$(gopass show creds/otel-bearer-token)"

export APPRISE_URLS="$(gopass show creds/apprise-urls)"

# Claude Code OTEL telemetry
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf
export OTEL_EXPORTER_OTLP_ENDPOINT=https://otel.dhruv.cc
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Bearer ${OTEL_BEARER_TOKEN}"
export OTEL_RESOURCE_ATTRIBUTES=plan=claude-max
export OTEL_METRIC_EXPORT_INTERVAL=10000
export OTEL_LOGS_EXPORT_INTERVAL=5000
