FROM nginx:latest
COPY _site /usr/share/nginx/html
ADD kmdotnet.conf /etc/nginx/conf.d/kmdotnet.conf
ADD tls.conf /etc/nginx/includes/tls.conf
ADD security_headers.conf /etc/nginx/includes/security_headers.conf
VOLUME /usr/share/nginx/html
EXPOSE 443