
default: all

all: env
	@mkdir -p /home/lle-cout/data/wordpress
	@mkdir -p /home/lle-cout/data/mariadb
	docker compose -f srcs/docker-compose.yml up --build -d

clean: down

fclean: clean
	@rm -rf /home/lle-cout/inception/srcs/.env
	@rm -rf /home/lle-cout/data/wordpress
	@rm -rf /home/lle-cout/data/mariadb
	docker rm -vf $(docker ps -aq)
	docker rmi -f $(docker images -aq)

re: fclean all

up: env
	docker compose -f srcs/docker-compose.yml up -f --build -d

down:
	docker compose -f srcs/docker-compose.yml down -d

env:
	/home/lle-cout/inception/srcs/requirements/tools/set_env.sh


.PHONY: all clean fclean re up down env
