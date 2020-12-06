#!/bin/sh
set -e

cat >/etc/caddy/Caddyfile <<EOF

EOF

fi

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile