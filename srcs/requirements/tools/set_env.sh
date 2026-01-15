#!/bin/bash

ENV_FILE='/home/lle-cout/inception/srcs/.env'

if [ -f "$ENV_FILE" ]; then
	if [ -s "$ENV_FILE" ]; then
		read -p "Pre-existing .env file found. Do you wish to overwrite ? [Y/n] " answer

		if [[ -z "$answer" || "$answer" =~ ^[Yy]$ ]]; then
			echo -e "Cleaning .env file...\n"
			> "$ENV_FILE"
		else
			echo -e "Aborting"
			exit 0
		fi
	fi
else
	echo -e "Creating .env file...\n"
	touch "$ENV_FILE"
fi

add_var() {
	local value;
	read -p "Enter your $1: " value
	echo "$2=$value" >> "$ENV_FILE"
}

echo -e "--- MariaDB variables ---"
add_var "database name" MYSQL_DATABASE
add_var "database user name" MYSQL_USER
add_var "database user password" MYSQL_PASSWORD
add_var "database root password" MYSQL_ROOT_PASSWORD

echo -e "\n--- Wordpress admin variables ---"
add_var "domain name" DOMAIN_NAME
add_var "Wordpress admin username" WP_ADMIN_USER
add_var "Wordpress admin password" WP_ADMIN_PASSWORD
add_var "Wordpress admin mail" WP_ADMIN_MAIL

echo -e "\n--- Wordpress user variables ---"
add_var "Wordpress user username" WP_USER
add_var "Wordpress user password" WP_USER_PASSWORD
add_var "Wordpress user mail" WP_USER_MAIL

echo -e "\n.env file created"
