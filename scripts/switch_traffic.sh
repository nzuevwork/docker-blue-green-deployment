cd ~/docker-blue-green-deployment

cat > scripts/switch_traffic.sh <<'EOF'
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

echo "Before:"
grep -n 'set $backend' "$CONF" || true

# Replace the exact directive (handles both spaces and quotes)
sed -i -E "s@set[[:space:]]+\\\$backend[[:space:]]+\"app-(blue|green)\";@set \\\$backend \"app-${TARGET}\";@g" "$CONF"

echo "After:"
grep -n 'set $backend' "$CONF" || true

# Fail fast if replacement didn't take effect
if ! grep -q "set \$backend \"app-${TARGET}\";" "$CONF"; then
  echo "ERROR: switch did not apply. Current line is:"
  grep -n 'set $backend' "$CONF" || true
  exit 2
fi

docker compose -f docker-compose.nginx.yml up -d
docker exec nginx-proxy nginx -t
docker exec nginx-proxy nginx -s reload

echo "Traffic switched to: ${TARGET}"
EOF

chmod +x scripts/switch_traffic.sh
dos2unix scripts/switch_traffic.sh >/dev/null 2>&1 || true
