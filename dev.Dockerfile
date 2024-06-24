FROM CodeWithBudi/eps-3-deploy-symfony-on-aws-apprunner-prod AS prod

RUN install-php-extensions xdebug
COPY docker/app-dev/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY docker/app-dev/error_reporting.ini /usr/local/etc/php/conf.d/error_reporting.ini
