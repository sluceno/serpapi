ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
TAG=$$(git log -1 --pretty=%h)

run:
	@echo "$(GREEN_COLOR)==> Starting crawler...$(NO_COLOR)"
	docker compose up crawler --build

rspec test:
	@echo "$(CYAN_COLOR)==> Runing tests...$(NO_COLOR)"
	docker-compose run crawler rspec $(ARGS)

destroy:
	@echo "$(RED_COLOR)==> Runing tests...$(NO_COLOR)"
	docker rm -f `docker ps -aq`
