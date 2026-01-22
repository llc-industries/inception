- [**Overview**](#overview)
- [**Managing the stack**](#managing-the-stack)
- [**Access the website**](#accessing-the-website-and-administration)
- [**Handling credentials**](#handling-credentials)
- [**Checking status**](#checking-service-status)

## Overview

This project provides a web stack running in isolated Docker containers:
- **Nginx:** The  entry point. It handles SSL/TLS encryption and serves the website via HTTPS.
- **WordPress (+PHP):** Website engine. To generate dynamic content and web pages.
- **MariaDB:** The database. To store all website data (articles, users, comments).

## Managing the stack

To start and stop the project, we use a Makefile with the following rules:

```bash
make # Use for build and start
```
```bash
make all # Same as above
```
```bash
make clean # Use to stop and delete containers
```
```bash
make fclean # Same as above + Delete wordpress and database data
```

There are also helper rules to handle containers lifetime and env:

```bash
make up # Start containers, make sure to have a build ready
```
```bash
make down # Stop running containers
```
```bash
make env # Call env helper script
```

## Accessing the website and administration

As a prerequisite, you need to manually map your domain name to your local ip, this can be done using the following command:
```bash
echo '127.0.0.1 lle-cout.42.fr' | sudo tee -a /etc/hosts
```

Once your containers are up, you can access your website [here](https://lle-cout.42.fr)
And your wordpress administration panel [here](https://lle-cout.42.fr/wp-admin)

Note: Accept the warning caused by your self signed certificate.

## Handling credentials

All credentials aren't hardcoded inside the project, instead we use an .env file to store these informations (at srcs/.env)

This file will be created automatically when you run make for the first time.

To change these credentials you must follow this procedure:
1. Stop the project using ```make down```
1. Edit srcs/.env manually OR delete it (rm srcs/.env) to regenerate it with ```make env```
1. Restart the project with ```make```

## Checking service status

To verify that the services are running correctly:
```bash
docker ps # Check active containers
```
You should see 3 containers (nginx, wordpress, mariadb) with the status Up.

If a service isn't working correctly, you should inspect its logs with the following:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```
