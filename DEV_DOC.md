- [**Using the right environment**](#using-the-right-environment)
- [**Configuration files**](#configuration-files)
- [**Managing secrets**](#managing-secrets)
- [**Build and start**](#build-and-start)
- [**Useful commands**](#useful-commands)
- [**Data storage and persistence**](#data-storage-and-persistence)

## Using the right environment

Your development environment should meet the following criteria:
- A **Unix**-like system
- Have the following **packages** installed:
	- git
	- make
	- docker
	- docker-compose
- Make sure you have access to **sudo** rights on your system, as its needed to handle persistent data, and to update your ```/etc/hosts``` file.

## Configuration files

Each service relies on configurations files that are pasted in the right container directory during image building.
These files can be found at:

[./srcs/requirements/nginx/conf/nginx.conf](./srcs/requirements/nginx/conf/nginx.conf) For Nginx configuration.

[./srcs/requirements/mariadb/conf/my.cnf](./srcs/requirements/mariadb/conf/my.cnf) For database configuration.

[./srcs/requirements/wordpress/tools/setup.sh](./srcs/requirements/wordpress/tools/setup.sh) This script is used to configure wordpress if no prior configuration has been done.

## Managing secrets

This project handles credentials data through environment variable injection into running containers.

These variables are stored in a .env file inside [./srcs](./srcs/) folder.

A helper script is provided to help set these different values, you can call it via:
```bash
make env
```

This script is automatically triggered when calling ```make```, in case a .env already exists, it will ask permission before overwriting it.

Please refer to the [script content](./srcs/requirements/tools/set_env.sh) to have a list of needed variables.

## Build and start

Lifecycle of the containers are managed through ```make```

For either a first start or a restart you should use the following command:
```bash
make # Build and start the service
```

Under the hood, this will run the following command:
```bash
docker compose -f srcs/docker-compose.yml up --build -d
```

It will build the images using **alpine 3.22**.
It will also create the necessary directories in the home folder for data.

## Useful commands

If any error occurs, you can check the logs (stdout/stderr) of a container by typing
```bash
docker logs mariadb # or nginx / wordpress
```
In case you need to manually intervene inside a container, you may use
```bash
docker exec -it mariadb sh
```
To access a shell inside the running container.

## Data storage and persistence

#### Data location

Wordpress and database data are stored on the host machine using bind mounts, this mechanism allows to achieve persistence.

Database content is stored at ~/data/mariadb \
Wordpress content is stored at ~/data/wordpress

At first run, the makefile will use mkdir -p to ensure the folders exists.

#### Persistence

Data is kept throughout services up/down cycles.

If you wish to start from scratch, you should use either of those make rules:
```bash
make fclean # Delete all images, networks, volumes, and bind folder
```
```bash
make re # Equivalent to running fclean && make
```

**Warning :** These rules run sudo rm -rf ~/data/mariadb ~/data/wordpress


