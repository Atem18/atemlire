#!/bin/bash
docker run --name=atemlire-dev --rm --volume="$PWD:/srv/jekyll" -p 4000:4000 -it jekyll/jekyll:4.1.0 jekyll serve --drafts --incremental