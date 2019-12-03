# Boilerplates I use for my projects (dev only)

## docker-php

This container uses an external network named *traefik* running a global traefik container.  
This php image built gives **alpine 3.10** with **php 7.3**.  
User and group are configured on *.env* file to allow php to write on the directory.

~~~sh
# update .env file
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
sed -i 's#\/var\/www#/var/www/public#g' docker/nginx.conf
rm -rf www
#composer create-project symfony/website-skeleton www
composer create-project symfony/skeleton www
#docker-compose down
#docker-compose up -d

# use symfony console on a running instance
alias sf='docker-compose run php php /var/www/bin/console'
~~~
