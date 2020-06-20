# Kmdotnet

My personnal website make with Jekyll hosted on AWS built and deployed by CircleCI.

## Development

```bash
export JEKYLL_VERSION=4.1.0
docker run --rm \
--volume="$PWD:/srv/jekyll" \
-p 4000:4000 \
-it jekyll/jekyll:$JEKYLL_VERSION \
jekyll serve
```

## Build

```bash
export JEKYLL_VERSION=4.1.0
docker run --rm \
--volume="$PWD:/srv/jekyll" \
-it jekyll/jekyll:$JEKYLL_VERSION \
jekyll build
```

## Deploy

```bash
aws s3 sync _site s3://kmdotnet-s3bucket-1ucv72i21hs6g --delete
```