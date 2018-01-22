FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY _site /usr/share/nginx/html
VOLUME /usr/share/nginx/html
EXPOSE 80
EXPOSE 443
