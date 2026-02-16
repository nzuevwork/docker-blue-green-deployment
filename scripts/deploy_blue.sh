#!/usr/bin/env bash
set -euo pipefail

docker compose up -d --build app-blue
./scripts/switch_traffic.sh blue

curl -fsS http://localhost | grep -E 'BLUE|GREEN' -n
