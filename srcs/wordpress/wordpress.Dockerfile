FROM debian:buster-20220822

ARG DB_WORDPRESS_USER
ARG DB_WORDPRESS_PASS
ARG DB_WORDPRESS_NAME
ARG WP_ADMIN_NAME
ARG WP_ADMIN_PASS
ARG WP_ADMIN_MAIL
ARG WP_USER_NAME
ARG WP_USER_PASS
ARG WP_USER_MAIL

# copy start script to fs root
COPY ./start.sh /start.sh
RUN ["/bin/chmod", "700", "/start.sh"]

# download wp tool to build the wordpress
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN ["/bin/chmod", "700", "/usr/local/bin/wp"]

# adding socket file for php7.4 fpm
RUN ["/bin/mkdir", "-p", "/run/php"]
RUN ["/usr/bin/touch", "php7.4-fpm.sock"]

RUN ["/usr/bin/apt", "update"]
# apt-transport-https + ca-certificates + wget => SSL download of the php GPG key into trusted repo
# netcat => healthcheck
# mysql => wordpress connector
RUN ["/usr/bin/apt", "install", "-y", "apt-transport-https", "ca-certificates", "wget", "netcat", "default-mysql-client"]
RUN ["/usr/bin/wget", "-O", "/etc/apt/trusted.gpg.d/php.gpg", "https://packages.sury.org/php/apt.gpg"]
RUN echo "deb https://packages.sury.org/php/ buster main" > /etc/apt/sources.list.d/php.list
RUN ["/usr/bin/apt", "update"]
RUN ["/usr/bin/apt", "install", "-y", "php7.4-fpm", "php7.4-cli", "php7.4-curl", "php7.4-mysql", "php7.4-gd", "php7.4-xml", "php7.4-mbstring", "php7.4-zip", "php7.4-soap", "php7.4-dev"]
RUN ["/usr/bin/update-alternatives", "--set", "php", "/usr/bin/php7.4"]
