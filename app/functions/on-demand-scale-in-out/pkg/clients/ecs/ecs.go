package ecs

import (
	"fmt"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ecs"
)

type ECSServiceNotFoundError struct {
	Arn string
	Msg string
}

func (e *ECSServiceNotFoundError) Error() string {
	return e.Msg
}

type ServiceCounts struct {
	DesiredCount int64
	RunningCount int64
}

type Client struct {
	client ecs.ECS
}

func New() (*Client, error) {

	sess, err := session.NewSession()

	if err != nil {
		return nil, fmt.Errorf("Handle: error while trying to create SDK session: %s", err)
	}

	client := ecs.New(sess)

	return &Client{*client}, nil
}

func (e *Client) UpdateServiceDesiredCount(arn string, count int64) error {

	return nil
}

func (e *Client) ObtainServiceCounts(arn string) (*ServiceCounts, error) {

	input := &ecs.DescribeServicesInput{
		Services: []*string{
			aws.String(arn),
		},
	}

	output, err := e.client.DescribeServices(input)

	if err != nil {
		return nil, fmt.Errorf("Handle: error while trying to get info of service %s: %s", arn, err)
	}

	if len(output.Services) == 0 {
		return nil, &ECSServiceNotFoundError{
			Arn: arn,
			Msg: fmt.Sprintf("Handle: service not found '%s' ", arn),
		}
	}

	return &ServiceCounts{
			*output.Services[0].DesiredCount,
			*output.Services[0].RunningCount},
		nil
}
