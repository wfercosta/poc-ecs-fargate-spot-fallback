build:
	go build -o  bin/main main.go

compile:
	GOARCH=amd64 GOOS=linux go build -o ./bin/main-linux-amd64 main.go

all: build compile