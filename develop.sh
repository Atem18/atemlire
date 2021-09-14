#!/bin/bash
rm -rf "$PWD/app/_site"

docker build -t atem18/atemlire:latest .

docker run --name=atemlire-dev --rm --volume="$PWD/app:/srv/jekyll" -p 4000:4000 -it atem18/atemlire:latest jekyll serve --drafts --incremental