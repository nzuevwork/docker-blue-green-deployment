#!/usr/bin/env bash
set -euo pipefail

docker compose up -d --build app-green
./scripts/switch_traffic.sh green

curl -fsS http://localhost | grep -E 'BLUE|GREEN' -n
