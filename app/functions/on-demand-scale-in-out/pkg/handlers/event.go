package handlers

type Event struct {
	Source              string `json:"source"`
	EventType           string `json:"event_type"`
	PrimaryServiceArn   string `json:"primary_service_arn"`
	SecondaryServiceArn string `json:"secondary_service_arn"`
}
