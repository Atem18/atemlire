#!/bin/bash

SERVICE_NAME="kmdotnet"
VIRTUAL_HOST="www.kevin-messer.net"

openssl aes-256-cbc -K "$encrypted_d7452885b0d3_key" -iv "$encrypted_d7452885b0d3_iv" -in deploy_rsa.enc -out /tmp/deploy_rsa -d

eval "$(ssh-agent -s)"

chmod 600 /tmp/deploy_rsa

ssh-add /tmp/deploy_rsa

docker run --rm -v /tmp/deploy_rsa:/root/.ssh/id_rsa -v /home/travis/build/Atem18/kmdotnet/_ansible:/ansible/playbooks atem18/ansible-playbook:latest -u kmdotnet -i www.kevin-messer.net, --extra-vars "SERVICE_NAME=$SERVICE_NAME VIRTUAL_HOST=$VIRTUAL_HOST" kmdotnet.yml
