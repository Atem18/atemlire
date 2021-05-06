#!/bin/bash
docker run --name=atemlire-dev --rm --volume="/Users/atem/Repos/atemlire/app:/srv/jekyll" -p 4000:4000 -it jekyll/jekyll:4.2.0 jekyll serve --drafts --incremental