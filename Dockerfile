FROM nginx:latest
COPY _site /usr/share/nginx/html
ADD kmdotnet.conf /etc/nginx/conf.d/kmdotnet.conf
VOLUME /usr/share/nginx/html
EXPOSE 443