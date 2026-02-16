#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"
if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: $0 {blue|green}"
  exit 1
fi

BACKEND="app-${TARGET}"

# ВАЖНО: имя сервиса nginx в compose может быть nginx или nginx-proxy.
# Сначала пробуем nginx, если не найден — пробуем nginx-proxy.
SERVICE="nginx"
if ! docker compose ps --services | grep -qx "$SERVICE"; then
  SERVICE="nginx-proxy"
fi

echo "Switching to: ${BACKEND} (service: ${SERVICE})"

# Пересоздаём nginx сервис с нужной переменной окружения
BACKEND="${BACKEND}" docker compose up -d --force-recreate "$SERVICE"

# Проверка
docker compose ps
curl -fsS http://localhost/__health >/dev/null && echo "health: ok"
curl -fsS http://localhost | grep -E 'BLUE|GREEN' -n || true
