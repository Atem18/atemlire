FROM golang:1.15.8-buster AS builder
RUN mkdir -p /caddydir/data && \
    chmod -R 700 /caddydir
ENV GO111MODULE=on \
    CGO_ENABLED=0
RUN go get github.com/caddyserver/xcaddy/cmd/xcaddy
ARG CADDY_VERSION=v2.3.0
WORKDIR /caddy
ARG PLUGINS=
RUN for plugin in $(echo $PLUGINS | tr "," " "); do withFlags="$withFlags --with $plugin"; done && \
    xcaddy build ${CADDY_VERSION} ${withFlags}

FROM scratch
COPY --from=builder /caddydir /caddydir
COPY Caddyfile /caddydir/Caddyfile
COPY --from=builder /caddy/caddy /caddy
ENTRYPOINT ["/caddy"]
CMD ["run","--config","/caddydir/Caddyfile"]
