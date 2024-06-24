# this is docker image for production
FROM composer:2 AS composer

FROM php:8.2-fpm-alpine
COPY --from=composer /usr/bin/composer /usr/local/bin/composer
WORKDIR /app

# add install-php-extensions
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# install php extensions
RUN install-php-extensions mysqli pdo_mysql intl

# setup PHP .ini
COPY docker/app-prod/error_reporting.ini /usr/local/etc/php/conf.d/error_reporting.ini

# configure PHP-FPM to forward error logs to Docker
RUN echo "catch_workers_output = yes" >> /usr/local/etc/php-fpm.d/www.conf

# install nginx
RUN apk add nginx
COPY docker/app-prod/site.conf /etc/nginx/http.d/*.conf

# deploy symfony app. see https://symfony.com/doc/current/deployment.html#common-deployment-tasks
COPY . /app
ENV APP_ENV=prod
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN apk add git zip
RUN composer install --no-dev --optimize-autoloader
RUN composer dump-env prod # dump .env file
RUN bin/console cache:clear --env=prod --no-debug
RUN bin/console cache:warmup --env=prod --no-debug
RUN apk del git zip

# run nginx by default
#CMD set -o monitor && trap exit SIGCHLD && (nginx -g 'daemon off;' &) && (php-fpm -F &) && wait
# run PHP-FPM in the foreground and Nginx in the background
CMD nginx -g 'daemon off;' & php-fpm
