#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"
if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: $0 {blue|green}"
  exit 1
fi

# copy template -> real .conf (nginx reads only .conf)
cp -f "nginx/${TARGET}.conf.tpl" "nginx/${TARGET}.conf"

# switch active symlink
ln -sf "${TARGET}.conf" nginx/active.conf

docker exec nginx-proxy nginx -t
docker exec nginx-proxy nginx -s reload

echo "Traffic switched to: ${TARGET}"
