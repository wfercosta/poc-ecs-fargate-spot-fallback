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
		return nil, fmt.Errorf("handle: error while trying to create SDK session: %s", err)
	}

	client := ecs.New(sess)

	return &Client{*client}, nil
}

func (e *Client) UpdateServiceDesiredCount(serviceArn string, clusterArn string, count int64) error {

	input := &ecs.UpdateServiceInput{
		DesiredCount: aws.Int64(count),
		Service:      aws.String(serviceArn),
		Cluster:      aws.String(clusterArn),
	}

	_, err := e.client.UpdateService(input)

	if err != nil {
		return fmt.Errorf("handle: error while trying to updated service %s desire count to %d: %s", serviceArn, count, err)
	}

	return nil
}

func (e *Client) ObtainServiceCounts(serviceArn string, clusterArn string) (*ServiceCounts, error) {

	input := &ecs.DescribeServicesInput{
		Services: []*string{
			aws.String(serviceArn),
		},
		Cluster: aws.String(clusterArn),
	}

	output, err := e.client.DescribeServices(input)

	if err != nil {
		return nil, fmt.Errorf("handle: error while trying to get info of service %s: %s", serviceArn, err)
	}

	if len(output.Services) == 0 {
		return nil, &ECSServiceNotFoundError{
			Arn: serviceArn,
			Msg: fmt.Sprintf("handle: service not found '%s' ", serviceArn),
		}
	}

	return &ServiceCounts{
			*output.Services[0].DesiredCount,
			*output.Services[0].RunningCount},
		nil
}
