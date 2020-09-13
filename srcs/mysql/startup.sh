#! /bin/sh

rc default
/etc/init.d/mariadb setup
rc-service mariadb start

# mysql -e "CREATE DATABASE wordpress_db;"
# mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';"
# mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin';"
# mysql -e "CREATE USER 'superuser'@'%' IDENTIFIED BY 'pass';"
# mysql -e "GRANT SELECT, INSERT, DELETE, UPDATE ON *.* TO 'superuser'@'%' IDENTIFIED BY 'pass';"
# mysql -e "CREATE USER 'dumbuser'@'%';"
# mysql -e "GRANT SELECT ON *.* TO 'dumbuser'@'%';"
# mysql -e "FLUSH PRIVILEGES;"
echo "create database wordpress;" | mysql
echo "grant all on *.* to admin@'%' identified by 'admin' with grant option; flush privileges;" | mysql
mysql wordpress < wordpress.sql

rc-service mariadb stop
/usr/bin/mysqld_safe
