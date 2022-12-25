package handlers

import (
	"context"
	"fmt"
	"log"
	"math"

	"github.com/wfercosta/aws/lambda/on-demand-scale-in/pkg/clients/ecs"
)

type HandlerServiceTaskPlacementFailure struct {
	context context.Context
	event   Event
}

func (h HandlerServiceTaskPlacementFailure) Handle() error {

	client, err := ecs.New()

	if err != nil {
		return fmt.Errorf("Handle: erro while trying to get client instance: %s", err)
	}

	counts, err := client.ObtainServiceCounts(h.event.PrimaryServiceArn)

	if err != nil {
		return fmt.Errorf("Handle: error while trying to get service %s counts: %s",
			h.event.PrimaryServiceArn,
			err)
	}

	deltaCount := (counts.DesiredCount - counts.RunningCount)
	desiredCount := deltaCount + int64((math.Ceil(float64(deltaCount) * 1.2)))

	log.Printf("Handle: New desired count set to %d for service %s",
		deltaCount,
		h.event.SecondaryServiceArn)

	if err :=
		client.UpdateServiceDesiredCount(
			h.event.SecondaryServiceArn,
			desiredCount); err != nil {

		return fmt.Errorf("Handle: error while trying to update the desired count for service %s: %s",
			h.event.SecondaryServiceArn,
			err)

	}

	return nil
}
