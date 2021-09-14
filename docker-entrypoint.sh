#!/bin/sh

bundle install

npm install

exec "$@"