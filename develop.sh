#!/bin/bash
docker run --name=kmdotnet-dev --rm --volume="$PWD:/srv/jekyll" -p 4000:4000 -it jekyll/jekyll:4 jekyll serve --drafts