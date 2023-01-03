FROM debian:buster-20220822

ARG DB_ROOT_PASS
ARG DB_WORDPRESS_USER
ARG DB_WORDPRESS_PASS
ARG DB_WORDPRESS_NAME

# Installs required dependencies
RUN ["/usr/bin/apt", "update"]
RUN ["/usr/bin/apt", "install", "-y", "mariadb-server"]

# Sets the default mode and options so we can later nondaemonize it on startup
RUN ["/usr/sbin/service", "mysql", "start"]

# --- Important: service mysql start is appended to each command for daemon to start
# --- Important: daemon is not kept between runs (docker standard)
# --- Important: it is not written in one line to make sure each query is successful
# Manual perform of mysql_secure_installation
RUN service mysql start && mysql -e "UPDATE mysql.user SET Password=PASSWORD('$DB_ROOT_PASS') WHERE User='root';"
RUN service mysql start && mysql -e "FLUSH PRIVILEGES;"
RUN service mysql start && mysql -e "DELETE FROM mysql.user WHERE User='';"
RUN service mysql start && mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
RUN service mysql start && mysql -e "DROP DATABASE IF EXISTS test;"
RUN service mysql start && mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
RUN service mysql start && mysql -e "UPDATE mysql.user SET plugin='' WHERE user='root' AND host='localhost';"
RUN service mysql start && mysql -e "FLUSH PRIVILEGES;"

# Manual setup of user
# --- Important: the hostname DNS will be wordpress.srcs_back_tier
# --- Important: changing the hostname of the service, the directory, or the network
# --- Important: may lead to problems
RUN service mysql start && mysql -e "CREATE DATABASE IF NOT EXISTS $DB_WORDPRESS_NAME;"
RUN service mysql start && mysql -e "CREATE USER IF NOT EXISTS '$DB_WORDPRESS_USER'@'wordpress.srcs_back_tier' IDENTIFIED BY '$DB_WORDPRESS_PASS';"
RUN service mysql start && mysql -e "FLUSH PRIVILEGES;"
RUN service mysql start && mysql -e "GRANT ALL PRIVILEGES ON $DB_WORDPRESS_NAME.* TO $DB_WORDPRESS_USER@\"wordpress.srcs_back_tier\";"
RUN service mysql start && mysql -e "FLUSH PRIVILEGES;"
