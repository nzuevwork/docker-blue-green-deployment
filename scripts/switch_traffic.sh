#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"
if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: $0 {blue|green}"
  exit 1
fi

CONF="nginx/default.conf"
if [[ ! -f "$CONF" ]]; then
  echo "Config not found: $CONF"
  exit 1
fi

sed -i -E "s/set \$backend \"app-(blue|green)\";/set \$backend \"app-${TARGET}\";/" "$CONF"

docker compose -f docker-compose.nginx.yml up -d
docker exec nginx-proxy nginx -t
docker exec nginx-proxy nginx -s reload

echo "Traffic switched to: ${TARGET}"

