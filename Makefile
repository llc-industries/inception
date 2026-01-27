COMPOSE_FILE = ./srcs/docker-compose.yml
COMPOSE = docker compose -f $(COMPOSE_FILE)
DATA_DIR = /home/lle-cout/data
ENV_FILE = ./srcs/.env
ENV_SCRIPT = ./srcs/requirements/tools/set_env.sh

default: all

# Basic rules

all: env
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/adminer
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/portainer
	$(COMPOSE) up --build -d
	@echo "Inception is up"

clean:
	$(COMPOSE) down --rmi all --volumes
	@echo "Containers are down, volumes and network cleaned"

fclean: clean
# 	@rm -rf $(ENV_FILE)
	@sudo rm -rf $(DATA_DIR)/wordpress
	@sudo rm -rf $(DATA_DIR)/adminer
	@sudo rm -rf $(DATA_DIR)/mariadb
	@sudo rm -rf $(DATA_DIR)/portainer
	@echo "Persistent storage and .env deleted"

re: fclean all

# Up / Down / Env

up:
	$(COMPOSE) up -d
	@echo "Containers are up"

down:
	$(COMPOSE) down
	@echo "Containers are down"

env:
	@echo "Calling .env script..."
	@bash $(ENV_SCRIPT)

.PHONY: all clean fclean re up down env
