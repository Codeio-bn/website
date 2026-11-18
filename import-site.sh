#!/usr/bin/env bash
# Zet de geexporteerde WordPress terug op de ANDERE laptop.
# Vooraf: `docker compose up -d` draaien en 1x wachten tot WordPress bereikbaar is op :8080.
# Daarna dit script draaien. Het verwacht de map ./site-backup (db-dump.sql + wp-content).
set -euo pipefail

cd "$(dirname "$0")"
SRC="site-backup"

if [ ! -f "$SRC/db-dump.sql" ] || [ ! -d "$SRC/wp-content" ]; then
  echo "FOUT: $SRC/db-dump.sql of $SRC/wp-content niet gevonden." >&2
  exit 1
fi

echo "==> Wachten tot WordPress de database kan bereiken..."
until docker compose run --rm -T wpcli wp db check >/dev/null 2>&1; do sleep 2; done

echo "==> wp-content terugzetten..."
docker cp "$SRC/wp-content/." codeio-wp:/var/www/html/wp-content
# rechten goedzetten voor de webserver-gebruiker
docker exec -u 0 codeio-wp chown -R www-data:www-data /var/www/html/wp-content

echo "==> Database importeren..."
docker cp "$SRC/db-dump.sql" codeio-wp:/var/www/html/_db-dump.sql
docker compose run --rm -T wpcli wp db import /var/www/html/_db-dump.sql
docker compose run --rm -T wpcli rm -f /var/www/html/_db-dump.sql

echo "==> Permalinks opnieuw doorspoelen..."
docker compose run --rm -T wpcli wp rewrite flush --hard >/dev/null 2>&1 || true

echo
echo "Klaar. Open http://localhost:8080  (admin / admin)"
