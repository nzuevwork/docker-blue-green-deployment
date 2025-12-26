#!/bin/bash
set -e

echo "[!] Rolling back traffic"

./switch_traffic.sh blue
