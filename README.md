# Templates I use for my projects (dev only)

## docker-php

This container uses an external network named *traefik* running a global traefik container.  
This php image built gives **alpine 3.9** with **php 7.2**.  
User and group are configured on *.env* file to allow php to write on the directory.

~~~sh
# update .env file
vi .env

# create and start comtainers
docker-compose up -d

# stop and clean containers (except db volume)
docker-compose down --rmi all

# download adminer if needed
wget -O www/adminer.php https://www.adminer.org/latest.php
~~~
