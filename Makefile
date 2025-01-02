tidy:
	go mod tidy && go mod vendor
build:
	docker build -t memogram .