#!/bin/bash

TARGET=$1

if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: ./switch_traffic.sh [blue|green]"
  exit 1
fi

echo "[+] Switching traffic to $TARGET"

sed -i "s/app-[a-z]*/app-$TARGET/" nginx/default.conf

docker compose -f docker-compose.nginx.yml restart nginx
