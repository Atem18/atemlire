FROM ruby:2.7.2-buster as builder-atemlire
WORKDIR /app
COPY ./app /app
RUN gem install bundler
RUN bundle install
RUN bundle exec jekyll build --config _config.yml
RUN bundle exec htmlproofer --url-ignore "/#.*/,/.*offline/,/.*404/,/www.kevin-messer.net/" _site

FROM caddy:2.2.1-alpine
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
COPY --from=builder-atemlire /app/_site /srv/