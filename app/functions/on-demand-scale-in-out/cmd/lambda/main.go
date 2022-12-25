package main

import (
	"context"
	"log"

	runtime "github.com/aws/aws-lambda-go/lambda"
	"github.com/wfercosta/aws/lambda/on-demand-scale-in/pkg/handlers"
)

func Run(context context.Context, event handlers.Event) error {

	log.Println("Run: processing the scalability action")
	log.Printf("Runn: event content: %+v", event)

	handler, err := handlers.NewHandler(context, event)

	if err != nil {
		log.Fatalf("Run: Error while trying to get the handler for the received event: %s ", err)
		return err
	}

	if err := handler.Handle(); err != nil {
		log.Fatalf("Run: Error while trying to process the request: %s ", err)
		return err
	}

	log.Println("Run: successfully executed the scalability action")

	return nil
}

func main() {
	runtime.Start(Run)
}
