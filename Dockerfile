FROM jekyll/builder
COPY --chown=jekyll:jekyll . /srv/jekyll
RUN bundle install
RUN jekyll build --destination /tmp/_site

FROM nginx:latest
LABEL "traefik.backend"="kmdotnet"
LABEL "traefik.docker.network"="kmdotnet"
LABEL "traefik.enable"="true"
LABEL "traefik.port"="80"
LABEL "traefik.frontend.entryPoints"="https"
LABEL "traefik.frontend.headers.forceSTSHeader"="true"
LABEL "traefik.frontend.headers.STSSeconds"="315360000"
LABEL "traefik.frontend.headers.STSIncludeSubdomains"="true"
LABEL "traefik.frontend.headers.STSPreload"="true"
LABEL "traefik.frontend.headers.SSLRedirect"="true"
LABEL "traefik.frontend.headers.SSLForceHost"="true"
LABEL "traefik.frontend.headers.SSLHost"="kevin-messer.net"
LABEL "traefik.frontend.rule"="Host:www.kevin-messer.net,kevin-messer.net"
LABEL "traefik.frontend.redirect.regex"="kevin-messer.net([/](.*))*"
LABEL "traefik.frontend.redirect.replacement"="https://www.kevin-messer.net$${1}"
LABEL "traefik.frontend.redirect.permanent"="true"
COPY kmdotnet.conf /etc/nginx/conf.d/kmdotnet.conf
COPY --from=0 --chown=nginx:nginx /tmp/_site /usr/share/nginx/html
VOLUME /usr/share/nginx/html
EXPOSE 80
