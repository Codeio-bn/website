#!/usr/bin/env bash
# Exporteert je lokale WordPress (database + wp-content) naar de map ./site-backup
# Draai dit op de HUIDIGE laptop, terwijl de containers draaien (docker compose up -d).
set -euo pipefail

cd "$(dirname "$0")"
OUT="site-backup"
mkdir -p "$OUT"

echo "==> Database exporteren..."
docker compose run --rm -T wpcli wp db export /var/www/html/_db-dump.sql
docker cp codeio-wp:/var/www/html/_db-dump.sql "$OUT/db-dump.sql"
docker compose run --rm -T wpcli rm -f /var/www/html/_db-dump.sql

echo "==> wp-content kopieren (thema, plugins, uploads/media)..."
rm -rf "$OUT/wp-content"
docker cp codeio-wp:/var/www/html/wp-content "$OUT/wp-content"

echo
echo "Klaar. Inhoud staat in ./$OUT"
echo "  - db-dump.sql   (de database)"
echo "  - wp-content/   (thema, plugins, media)"
echo "Commit en push dit, dan haal je het op de andere laptop op met import-site.sh"
