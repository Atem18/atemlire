---
title: How to develop and build a Wordpress theme inside a container

---
Hi,

Today we will learn about developping, building and deploying a wordpress theme

```yaml
version: '3'
services:
  db:
    container_name: wordpress-db
    image: mariadb:10.5.8
    restart: unless-stopped
    volumes:
      - ./dev/db/data:/var/lib/mysql
      - ./dev/db/entrypoint:/docker-entrypoint-initdb.d
    ports:
      - "3306:3306"
    networks:
      - gog
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
  wordpress:
    depends_on:
      - db
    container_name: wordpress-fpm
    build:
      context: ./wordpress
    restart: unless-stopped
    volumes:
      - ./wordpress/mytheme.ini:/usr/local/etc/php/conf.d/mytheme.ini
      - ./dev/wordpress:/var/www/html
      - ./gog:/var/www/html/wp-content/themes/mytheme
    networks:
      - gog
    environment:
      WORDPRESS_DB_HOST: wordpress-db
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
  node:
    container_name: wordpress-node
    build:
      context: ./node
    restart: unless-stopped
    volumes:
      - ./mytheme:/app
  caddy:
    container_name: wordpress-caddy
    build:
      context: ./caddy
    restart: unless-stopped
    volumes:
      - ./caddy/certs:/etc/caddy/certs
      - ./dev/wordpress:/var/www/html
      - ./mytheme:/var/www/html/wp-content/themes/mytheme
    ports:
      - "80:80"
      - "443:443"
    networks:
      - mytheme
networks:
  mytheme:
```