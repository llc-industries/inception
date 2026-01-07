#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

    cat << EOF > /tmp/init.sql
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    /usr/bin/mariadbd --user=mysql --bootstrap < /tmp/init.sql

    rm -f /tmp/init.sql
fi

exec /usr/bin/mariadbd --user=mysql --console
