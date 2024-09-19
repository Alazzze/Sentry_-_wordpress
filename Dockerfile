FROM wordpress:php8.2

# Update the package and install the necessary tools
RUN apt-get update && \
    apt-get install -y wget gnupg curl tar unzip libzip-dev && \
    docker-php-ext-install zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Add permissions for Composer
ENV COMPOSER_ALLOW_SUPERUSER=1

# Copy project files
COPY composer.json /var/www/html/
RUN composer install

COPY . /var/www/html/


# Copy a Sentry test error file
COPY test_sentry.php /var/www/html/

# Copying the PHP configuration file
COPY php.ini /usr/local/etc/php/


# Copying the Sentry configuration file for PHP
COPY sentry.ini /usr/local/etc/php/conf.d/sentry.ini

# Setting permissions for a configuration file
RUN chmod 644 /usr/local/etc/php/conf.d/sentry.ini
