FROM jekyll/jekyll:4.2.2

RUN apk add --no-cache vips vips-tools

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]