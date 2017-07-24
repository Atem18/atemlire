[![Build Status](https://travis-ci.org/Atem18/kmdotnet.svg?branch=master)](https://travis-ci.org/Atem18/kmdotnet)

### Build

export IMAGE_NAME=atem18/kmdotnet:$BITBUCKET_COMMIT

docker build -t $IMAGE_NAME .

docker login --username $DOCKER_HUB_USERNAME --password $DOCKER_HUB_PASSWORD

docker push $IMAGE_NAME

### Deploy

ansible-playbook -i hosts --limit=www.kevin-messer.net -u atem --private-key ~/.ssh/atemlenetec2.pem -b --extra-vars "BITBUCKET_COMMIT=$BITBUCKET_COMMIT" kmdotnet.yml