build:
	go build -o  bin/main cmd/lambda/main.go

compile:
	GOARCH=amd64 GOOS=linux go build -o ./bin/main-linux-amd64 cmd/lambda/main.go

all: build compile