package handlers

type EventTypeNotSupportedError struct {
	EventType string
	Msg       string
}

func (e *EventTypeNotSupportedError) Error() string {
	return e.Msg
}
