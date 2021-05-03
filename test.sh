#!/bin/bash
docker run --name=atemlire-builder --rm --volume="/Users/atem/Repos/atemlire/app:/srv/jekyll" -e JEKYLL_ENV=production jekyll/jekyll:4.2.0 jekyll build --profile

docker run --name=atemlire-test --rm --volume="/Users/atem/Repos/atemlire/app/_site:/usr/share/caddy" -p 4444:80 caddy:2.3.0-alpine