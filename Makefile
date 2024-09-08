#!make
include .env


SERVICE_NAME=mysql
HOST=127.0.0.1
PORT=3306

PASSWORD=${MYSQL_ROOT_PASSWORD}
DATABASE=${MYSQL_DATABASE}
USER=${MYSQL_USER}

DOCKER_COMPOSE_FILE=./docker-compose.yml
DATABASE_CREATION=./structure/CafeAlPaso_DiazPaula.sql
DATABASE_POPULATION=./structure/population.sql


FILES = Views functions stored_procedures Triggers roles_users

.PHONY: all up objects test-db access-db down

all: info up objects

info:
	@echo "This is a project for $(DATABASE)"
	

up:
	@echo "Create the instance of docker"
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

	@echo "Waiting for MySQL to be ready..."
	bash wait_docker.sh


	@echo "Create the import and run de script"
	docker exec -it $(SERVICE_NAME) mysql -u root -p$(PASSWORD) -e "source $(DATABASE_CREATION);"
	docker exec -it $(SERVICE_NAME) mysql -u root -p$(PASSWORD) --local-infile=1 -e "source $(DATABASE_POPULATION)"

objects:
	@echo "Create objects in database"
	@for file in $(FILES); do \
	    echo "Process $$file and add to the database: $(DATABASE_NAME)"; \
	docker exec -it $(SERVICE_NAME)  mysql -u$(MYSQL_USER) -p$(PASSWORD) -e "source ./sql_project/database_objects/$$file.sql"; \
	done

test-db:
	@echo "Testing the tables"
	@TABLES=$$(docker exec -it $(SERVICE_NAME) mysql -u root -p$(PASSWORD) -N -B -e "USE $(DATABASE_NAME); SHOW TABLES;"); \
	for TABLE in $$TABLES; do \
		echo "Table: $$TABLE"; \
		docker exec -it $(SERVICE_NAME) mysql -u root -p$(PASSWORD) -N -B -e "USE $(DATABASE_NAME); SELECT * FROM $$TABLE LIMIT 5;"; \
		echo "----------------------------------------------"; \
	done

access-db:
	@echo "Access to db-client"
	docker exec -it $(SERVICE_NAME) mysql -u$(MYSQL_USER) -p$(PASSWORD) 

backup-db:
	@echo "Back up database by structure and data"
	# Dump MySQL database to a file
	docker exec -it $(SERVICE_NAME) mysqldump -u root -p$(PASSWORD) $(DATABASE) > ./backup/$(DATABASE)-$$(date +'%Y-%m-%d').

clean-db:
	@echo "Remove the Database"
	docker exec -it $(SERVICE_NAME) mysql -u root -p$(PASSWORD) --host $(HOST) --port $(PORT) -e "DROP DATABASE IF EXISTS $(DATABASE);"
	@echo "Bye"
	docker compose -f $(DOCKER_COMPOSE_FILE) down
