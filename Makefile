init-dependency:
	go get -u github.com/antonfisher/nested-logrus-formatter
	go get -u github.com/gin-gonic/gin
	go get -u golang.org/x/crypto
	go get -u gorm.io/gorm
	go get -u gorm.io/driver/postgres
	go get -u github.com/sirupsen/logrus
	go get -u github.com/joho/godotenv

define make-directories
	mkdir -p app/constant app/controller app/domain/dao app/domain/dto \
	app/pkg app/repository app/router app/service config deployments/dev deployments/prod
endef

define make-files
	echo "package main" > main.go
	echo "package constant" > app/constant/constant.go
	echo "package pkg" | tee -a app/pkg/error.go app/pkg/error_handler.go app/pkg/response_util.go
	echo "package router" > app/router/router.go
	echo "package config" | tee -a config/wire_gen.go config/logger.go config/injector.go config/init.go config/database.go
	touch deployments/dev/.env deployments/dev/docker-compose.dev.yaml
	touch deployments/prod/.env deployments/prod/docker-compose.prod.yaml
endef

init-project:
	go mod init
	git remote remove
	$(make-directories)
	$(make-files)

clear-project:
	rm -rf app config deployments main.go
	rm -rf go.mod
