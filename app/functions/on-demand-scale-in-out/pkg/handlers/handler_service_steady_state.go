package handlers

import (
	"context"
	"fmt"

	"github.com/wfercosta/aws/lambda/on-demand-scale-in/pkg/clients/ecs"
)

type HandlerServiceSteadyState struct {
	context context.Context
	event   Event
}

func (h HandlerServiceSteadyState) Handle() error {

	client, err := ecs.New()

	if err != nil {
		return fmt.Errorf("Handle: erro while trying to get client instance: %s", err)
	}

	if err :=
		client.UpdateServiceDesiredCount(h.event.SecondaryServiceArn, 0); err != nil {

		return fmt.Errorf("Handle: error while trying to update the desired count for service %s: %s",
			h.event.SecondaryServiceArn,
			err)
	}

	return nil
}
