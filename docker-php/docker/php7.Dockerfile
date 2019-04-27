FROM alpine:3.9

# Build arguments to configure php
ARG PHP_PORT=9000
ARG PHP_USER=nobody
ARG PHP_GROUP=nobody

# First install all packages to reflect php official dockerfile content
# Then install other useful packages
RUN apk --no-cache add \
        php7 \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-fileinfo \
        php7-fpm \
        php7-ftp \
        php7-iconv \
        php7-json \
        php7-mbstring \
        php7-mysqlnd \
        php7-openssl \
        php7-pdo \
        php7-pdo_sqlite \
        php7-pear \
        php7-phar \
        php7-posix \
        php7-session \
        php7-simplexml \
        php7-sqlite3 \
        php7-tokenizer \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-zlib \

        php7-gd \
        php7-mysqli

# Create volume shared with other containers
RUN sed -e "s|^;*clear_env\s*=.*$|clear_env = no|" \
        -e "s|^;*listen\s*=.*$|listen = ${PHP_PORT}|" \
        -e "s|^;*user\s*=.*$|user = ${PHP_USER}|" \
        -e "s|^;*group\s*=.*$|group = ${PHP_GROUP}|" \
        -i /etc/php7/php-fpm.d/www.conf

# Create volume shared with other containers
VOLUME ["/var/www"]

# Expose default php-fpm port
EXPOSE ${PHP_PORT}

# Launch php-fpm in foreground
CMD ["/usr/sbin/php-fpm7", "-F"]
