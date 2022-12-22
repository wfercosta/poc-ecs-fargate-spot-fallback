package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	runtime "github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context, event events.CloudWatchEvent) error {

	fmt.Printf("Source: %+v\n", event.Source)
	fmt.Printf("DetailType: %+v\n", event.DetailType)
	fmt.Printf("Detail: %v\n", event.Detail)

	return nil
}

func main() {
	runtime.Start(handler)
}
