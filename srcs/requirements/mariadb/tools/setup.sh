#!/bin/sh

DATADIR="/var/lib/mysql"

if [ ! -d "$DATADIR/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=$DATADIR

    /usr/bin/mariadbd --user=mysql --datadir=$DATADIR &
    PID=$!

    until mariadb-admin ping >/dev/null 2>&1; do
        sleep 1
    done

    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mariadb -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    kill $PID
    wait $PID
fi

exec /usr/bin/mariadbd --user=mysql --datadir=$DATADIR
