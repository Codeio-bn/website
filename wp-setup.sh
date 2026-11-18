#!/usr/bin/env bash
# Eenmalige setup voor de lokale WordPress + WordPress MCP plugin.
# Draai dit NADAT `docker compose up -d` loopt en WordPress bereikbaar is op http://localhost:8080
set -euo pipefail

SITE_URL="http://localhost:8080"
ADMIN_USER="admin"
ADMIN_PASS="admin"
ADMIN_EMAIL="thepumpkingamer6@gmail.com"
MCP_PLUGIN_URL="https://github.com/Automattic/wordpress-mcp/releases/download/v0.2.5/wordpress-mcp.zip"

wp() { docker compose run --rm -T wpcli wp "$@"; }

echo "==> Wachten tot WordPress de database kan bereiken..."
until wp db check >/dev/null 2>&1; do sleep 2; done

if wp core is-installed >/dev/null 2>&1; then
  echo "==> WordPress is al geinstalleerd, installatie overslaan."
else
  echo "==> WordPress core installeren (verse, lege site)..."
  wp core install \
    --url="$SITE_URL" \
    --title="codeio lokaal" \
    --admin_user="$ADMIN_USER" \
    --admin_password="$ADMIN_PASS" \
    --admin_email="$ADMIN_EMAIL" \
    --skip-email
fi

echo "==> WordPress MCP plugin installeren + activeren..."
wp plugin install "$MCP_PLUGIN_URL" --activate --force

echo "==> Permalinks op 'pretty' zetten (nodig voor de REST/MCP endpoints)..."
wp rewrite structure '/%postname%/' --hard >/dev/null 2>&1 || true
wp rewrite flush --hard >/dev/null 2>&1 || true

echo
echo "===================================================================="
echo " Klaar met de automatische stappen."
echo " WordPress admin : $SITE_URL/wp-admin   (admin / admin)"
echo
echo " Nu nog handmatig in de admin:"
echo "   1. Ga naar  Settings > MCP"
echo "   2. Zet 'Enable MCP functionality' AAN en sla op."
echo "   3. Tab 'Authentication Tokens' > genereer een JWT (kies looptijd)."
echo "      Kopieer het token METEEN (is daarna niet meer zichtbaar)."
echo
echo " Daarna verbinden met Claude Code:"
echo "   claude mcp add --transport http wordpress-mcp \\"
echo "     $SITE_URL/wp-json/wp/v2/wpmcp/streamable \\"
echo "     --header \"Authorization: Bearer <JOUW_JWT_TOKEN>\""
echo "===================================================================="
