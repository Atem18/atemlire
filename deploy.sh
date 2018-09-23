#!/bin/bash

BRANCH=$1

if [ "$BRANCH" = "develop" ];then

    SERVICE_NAME="kmdotnet-testing"
    VIRTUAL_HOST="www.testing.kevin-messer.net"

elif [ "$BRANCH" = "content" ];then

    SERVICE_NAME="kmdotnet-staging"
    VIRTUAL_HOST="www.staging.kevin-messer.net"

elif [ "$BRANCH" = "master" ];then

    SERVICE_NAME="kmdotnet"
    VIRTUAL_HOST="www.kevin-messer.net"

fi

openssl aes-256-cbc -K "$encrypted_d7452885b0d3_key" -iv "$encrypted_d7452885b0d3_iv" -in deploy_rsa.enc -out /tmp/deploy_rsa -d

eval "$(ssh-agent -s)"

chmod 600 /tmp/deploy_rsa

ssh-add /tmp/deploy_rsa

docker run --rm -v /tmp/deploy_rsa:/root/.ssh/id_rsa -v /home/travis/build/Atem18/kmdotnet/_ansible:/ansible/playbooks atem18/ansible-playbook:c9382b16c708777f0f194ae851520a94d6be480d -i www.kevin-messer.net, --extra-vars "TRAVIS_COMMIT=$TRAVIS_COMMIT SERVICE_NAME=$SERVICE_NAME VIRTUAL_HOST=$VIRTUAL_HOST" kmdotnet.yml