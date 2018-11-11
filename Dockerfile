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
COPY nginx.conf /etc/nginx/nginx.conf
COPY kmdotnet.conf /etc/nginx/conf.d/kmdotnet.conf
COPY _site /usr/share/nginx/html
VOLUME /usr/share/nginx/html
EXPOSE 80
