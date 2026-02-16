cat > scripts/switch_traffic.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"
if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: $0 {blue|green}"
  exit 1
fi

CONTAINER="nginx-proxy"
CONF="/etc/nginx/conf.d/default.conf"

echo "Before (inside container):"
docker exec "$CONTAINER" sh -lc "grep -n 'set \\$backend' $CONF || true"

# Replace inside container
docker exec "$CONTAINER" sh -lc \
  "sed -i -E 's@(^[[:space:]]*set[[:space:]]+\\$backend[[:space:]]+\")app-(blue|green)(\";)@\\1app-${TARGET}\\3@' $CONF"

echo "After (inside container):"
docker exec "$CONTAINER" sh -lc "grep -n 'set \\$backend' $CONF || true"

docker exec "$CONTAINER" nginx -t
docker exec "$CONTAINER" nginx -s reload

echo "Traffic switched to: ${TARGET}"
EOF

chmod +x scripts/switch_traffic.sh
dos2unix scripts/switch_traffic.sh >/dev/null 2>&1 || true
