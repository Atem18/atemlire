#!/bin/sh
set -e

if [ $NODE_ENV = "production" ];then

cat > /etc/caddy/Caddyfile << EOF
http://www.kevin-messer.net {
  root * /srv/
  file_server
  encode gzip zstd
  respond /live 200
  respond /ready 200
}
EOF

elif [ $NODE_ENV = "ci" ];then
cat > /etc/caddy/Caddyfile << EOF
:80 {
  respond /live 200
  respond /ready 200
}
EOF

else

cat >/etc/caddy/Caddyfile <<EOF
http://www.local.kevin-messer.net {
  root * /srv/
  file_server
  encode gzip zstd
  respond /live 200
  respond /ready 200
}
EOF

fi

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile