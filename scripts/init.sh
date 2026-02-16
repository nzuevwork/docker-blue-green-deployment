#!/usr/bin/env bash
set -euo pipefail

# create active.conf if missing
if [[ ! -e nginx/active.conf ]]; then
  ln -sf blue.conf nginx/active.conf
fi

docker compose up -d --build
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
