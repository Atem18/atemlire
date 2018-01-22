FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY _site /usr/share/nginx/html
ADD tls.conf /etc/nginx/includes/tls.conf
ADD security_headers.conf /etc/nginx/includes/security_headers.conf
ADD kmdotnet.conf /etc/nginx/conf.d/kmdotnet.conf
VOLUME /usr/share/nginx/html
EXPOSE 80
EXPOSE 443
