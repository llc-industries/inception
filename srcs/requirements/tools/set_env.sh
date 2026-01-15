#!/bin/sh

ENV_FILE='/home/lle-cout/inception/srcs/.env'

if [ -f "$ENV_FILE" ]; then
	echo "Cleaning .env file...\n"
	> "$ENV_FILE"
else
	echo "Creating .env file...\n"
	touch "$ENV_FILE"
fi

add_var()


