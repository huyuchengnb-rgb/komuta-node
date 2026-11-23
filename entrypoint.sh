#!/bin/sh
set -e
: "${UUID:?UUID env var is required}"
WS_PATH="${WS_PATH:-/ws}"
PORT="${PORT:-8080}"
sed -e "s|__UUID__|${UUID}|g" -e "s|__WS_PATH__|${WS_PATH}|g" -e "s|__PORT__|${PORT}|g" /usr/local/xray/config.template.json > /usr/local/xray/config.json
exec /usr/local/xray/xray run -config /usr/local/xray/config.json
