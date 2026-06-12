#!/bin/sh
set -e

CONFIG_PATH="/usr/share/nginx/html/vapt_iaura_services/config.js"

# Generate window.__RUNTIME_CONFIG__ from environment variables at startup
cat > "$CONFIG_PATH" <<EOF
window.__RUNTIME_CONFIG__ = {
  API_BASE_URL: "${API_BASE_URL:-}",
  APP_ENV: "${APP_ENV:-production}"
};
EOF

echo "[entrypoint] config.js written to $CONFIG_PATH"

exec "$@"
