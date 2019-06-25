#!/bin/bash
docker build -t atem18/kmdotnet:$TRAVIS_COMMIT .
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push atem18/kmdotnet:$TRAVIS_COMMIT