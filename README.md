# Boilerplates used for my projects (dev only)

The first thing to do is to start base docker configuration.

## Base

This container composition adds a external network named *traefik*.  
In this network, a **traefik** reverse proxy and **portainer** docker admin are started.  
They restart at docker launch and allow to use an https tld domaine *.localhost* (configurable).

~~~sh
# install docker (archlinux)
pacman -S docker docker-compose
systemctl enable --now docker

# generate https private self generated certificate
openssl req -x509 -nodes -newkey rsa:2048 -keyout traefik/cert.key -out traefik/cert.crt \
            -subj "/C=FR/ST=Anywhere but/L=Paris/O=Localhost/OU=Development/CN=*.localhost"

# or generate letsencrypt certificate
touch traefik/letsencrypt.json
vim traefik/traefik.toml # comment private certificate block and uncomment let's encrypt block

# update env file (optional)
cp .env.dist .env
vim .env

# create and start containers
docker-compose up -d

# stop base containers
docker-compose down --rmi all

# access containers
xdg-open https://traefik.base.localhost
xdg-open https://portainer.base.localhost
~~~

## PHP

This container uses an external network named *traefik* running a global traefik container.  
This php image built gives **alpine 3.10** with **php 7.3**.  
User and group are configured on *.env* file to allow php to write on the directory.

~~~sh
# update .env file (user, group and project name)
mv .env.dist .env
vim .env

# create and start comtainers
docker-compose up -d

# stop and clean containers (except db volume)
docker-compose down --rmi all

# show logs
docker-compose logs -f

# download adminer if needed
wget -O www/adminer.php https://www.adminer.org/latest.php

# download composer if needed
wget -O www/composer.phar https://getcomposer.org/download/1.9.1/composer.phar

# download wordpress if needed
wget -O - https://fr.wordpress.org/latest-fr_FR.tar.gz | tar -xzC www --strip-components=1

# install symfony if needed
sed -i 'cs#\/var\/www#/var/www/public#g' docker/nginx.conf
rm -rf www
#composer create-project symfony/website-skeleton www
composer create-project symfony/skeleton www
#docker-compose down
#docker-compose up -d

# use symfony console on a running instance
alias sf='docker-compose exec php php /var/www/bin/console'
alias composer='docker-compose exec php php /var/www/composer.phar'
~~~
