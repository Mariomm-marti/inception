#!/bin/bash

# Install wordpress
/usr/local/bin/wp core download --path=/var/www/mmartin.42.fr --locale=en_GB --allow-root
/usr/local/bin/wp config create "--dbname=$DB_WORDPRESS_NAME" "--dbuser=$DB_WORDPRESS_USER" "--dbpass=$DB_WORDPRESS_PASS" --dbhost=db --locale=en_GB --path=/var/www/mmartin.42.fr --allow-root
/usr/local/bin/wp core install --url=mmartin.42.fr --title=supermario "--admin_user=$WP_ADMIN_NAME" "--admin_password=$WP_ADMIN_PASS" "--admin_email=$WP_ADMIN_MAIL" --locale=en_GB --skip-email --path=/var/www/mmartin.42.fr --allow-root
/usr/local/bin/wp user create "$WP_USER_NAME" "$WP_USER_MAIL" --role=author "--user_pass=$WP_USER_PASS" --path=/var/www/mmartin.42.fr --allow-root

/usr/sbin/php-fpm7.4 -F -c /etc/php/7.4/fpm/php.ini
