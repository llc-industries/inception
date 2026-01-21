#!/bin/sh

DATADIR="/var/lib/mysql"

# Check if mariadb is installed, proceed if not
if [ ! -d "$DATADIR/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=$DATADIR

# Tmp process to setup db
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

# Start mariadb everytime through entrypoint
exec /usr/bin/mariadbd --user=mysql --datadir=$DATADIR
