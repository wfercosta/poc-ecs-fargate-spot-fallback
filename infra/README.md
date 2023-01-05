```
{
    "version": "0",
    "id": "c8909073-5312-0734-85ac-9c312b2e4c43",
    "detail-type": "ECS Service Action",
    "source": "test",
    "account": "175898361931",
    "time": "2023-01-05T11:45:20Z",
    "region": "us-east-1",
    "resources": [
        "arn:aws:ecs:us-east-1:175898361931:service/demo/httpbin-service-fargate"
    ],
    "detail": {
        "eventType": "INFO",
        "eventName": "SERVICE_TASK_PLACEMENT_FAILURE",
        "clusterArn": "arn:aws:ecs:us-east-1:175898361931:cluster/demo",
        "createdAt": "2023-01-05T11:45:20.200Z"
    }
}

{
    "eventType": "INFO",
    "eventName": "SERVICE_TASK_PLACEMENT_FAILURE",
    "clusterArn": "arn:aws:ecs:us-east-1:175898361931:cluster/demo",
    "createdAt": "2023-01-05T11:45:20.200Z"
}
```

023/01/05 11:50:54 Run: Error while trying to process the request: Handle: error while trying to get service arn:aws:ecs:us-east-1:175898361931:service/demo/httpbin-service-fargate counts: Handle: error while trying to get info of service arn:aws:ecs:us-east-1:175898361931:service/demo/httpbin-service-fargate: AccessDeniedException: User: arn:aws:sts::175898361931:assumed-role/lambda-function-role/on-demand-scale-in-out is not authorized to perform: ecs:DescribeServices on resource: arn:aws:ecs:us-east-1:175898361931:service/default/httpbin-service-fargate because no identity-based policy allows the ecs:DescribeServices action
