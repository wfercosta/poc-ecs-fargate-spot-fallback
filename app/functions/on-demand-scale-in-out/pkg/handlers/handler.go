package handlers

import (
	"context"
	"fmt"
)

type Handler interface {
	Handle() error
}

func NewHandler(context context.Context, event Event) (Handler, error) {
	switch e := event.EventType; e {
	case "SERVICE_TASK_PLACEMENT_FAILURE":
		return HandlerServiceTaskPlacementFailure{context, event}, nil
	case "SERVICE_STEADY_STATE":
		return HandlerServiceSteadyState{context, event}, nil
	default:
		return nil, &EventTypeNotSupportedError{
			EventType: e,
			Msg:       fmt.Sprintf("event type informed '%s' is not supported", e),
		}
	}
}
