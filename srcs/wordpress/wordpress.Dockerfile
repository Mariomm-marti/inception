FROM debian:buster-20220822

RUN ["/usr/bin/apt", "update"]
RUN ["/usr/bin/apt", "install", "-y", "apt-transport-https ca-certificates wget netcat"]
RUN ["/usr/bin/wget", "-O", "/etc/apt/trusted.gpg.d/php.gpg", "https://packages.sury.org/php/apt.gpg"]
RUN echo "deb https://packages.sury.org/php/ buster main" > /etc/apt/sources.list.d/php.list
RUN ["/usr/bin/apt", "update"]
RUN ["/usr/bin/apt", "install", "-y", "php7.4-fpm", "php7.4-cli", "php7.4-curl", "php7.4-mysql", "php7.4-gd", "php7.4-xml", "php7.4-mbstring", "php7.4-zip", "php7.4-soap", "php7.4-dev"]
RUN ["/usr/bin/update-alternatives", "--set", "php", "/usr/bin/php7.4"]
