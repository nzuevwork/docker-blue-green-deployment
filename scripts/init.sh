#!/usr/bin/env bash
set -euo pipefail

docker network inspect app_net >/dev/null 2>&1 || docker network create app_net >/dev/null

docker compose -f docker-compose.nginx.yml up -d
echo "Nginx is up. app_net ready."
