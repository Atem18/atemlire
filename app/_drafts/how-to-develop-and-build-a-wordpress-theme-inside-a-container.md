---
title: How to develop and build a WordPress theme inside a container
---

Hi folks, today we will learn about developing and building a WordPress theme inside a container.

We will use Docker compose because infrastructure as code is the way to go nowadays.

If you don't know yet Docker compose, please go to [https://docs.docker.com/compose/](https://docs.docker.com/compose/ "https://docs.docker.com/compose/") and come back to this tutorial.

If you know already everything, here is the Github repo : [https://github.com/Atem18/docker-wordpress](https://github.com/Atem18/docker-wordpress "https://github.com/Atem18/docker-wordpress")

For reference, here is the Docker Compose we will use:

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

## Develop

As you can see upper in the compose file, we start MariaDB, WordPress, Node.js and Caddy.

### MariaDB

Nothing fancy here, we just use the official MariaDB image.

What only changes is that we mount data into a local folder so it's not lost when we restart the container.

And we also mount a local folder so we can easily restore a dump from production.

### WordPress

Here comes the first interesting part.

```dockerfile
FROM wordpress:php7.4-fpm
COPY mytheme.ini /usr/local/etc/php/conf.d/mytheme.ini
EXPOSE 9000
```

### Node.js

### Caddy

## Build