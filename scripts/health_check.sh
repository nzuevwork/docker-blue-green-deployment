#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"
if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: $0 {blue|green}"
  exit 1
fi

NAME="app-${TARGET}"

if ! docker inspect "$NAME" >/dev/null 2>&1; then
  echo "Container $NAME not found."
  exit 1
fi

echo "Health-check $NAME ..."
docker run --rm --network app_net curlimages/curl:8.6.0 \
  -fsS "http://${NAME}/" >/dev/null

echo "OK: $NAME отвечает."
