#!/bin/sh

while ! /usr/bin/mariadb-admin ping -h"mariadb" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do # Tant que la connexion à la base de données échoue, la boucle continue
	sleep 1
done

if [ ! -f wp-config.php ]; then
	wp core download --allow-root
fi

if ! wp core is-installed 2>/dev/null; then
    wp config create --allow-root \
	--dbname=$MYSQL_DATABASE \
	--dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD \
	--dbhost=mariadb:3306

	wp core install --allow-root \
	--url=$DOMAIN_NAME \
	--title=Inception \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_MAIL

	wp user create --allow-root \
	$WP_USER \
	$WP_USER_MAIL \
	--user_pass=$WP_USER_PASSWORD \
	--role=editor
fi

exec /usr/sbin/php-fpm83 -F
