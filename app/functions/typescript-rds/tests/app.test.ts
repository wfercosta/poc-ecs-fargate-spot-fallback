import { describe, expect, test} from '@jest/globals';
import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { handler } from '../src/app';

describe('Unit test for app handler', () => {

    test('Run an test example', async () => {
        
        const event: APIGatewayProxyEvent = {
            body: null,
            headers: {},
            multiValueHeaders: {},
            httpMethod: 'POST',
            isBase64Encoded: false,
            path: '',
            pathParameters: null,
            queryStringParameters: null,
            multiValueQueryStringParameters: null,
            stageVariables: null,
            requestContext: {
                accountId: '',
                apiId: '',
                authorizer: {},
                httpMethod: 'post',
                protocol: '',
                path: '',
                stage: '',
                requestId: '',
                requestTimeEpoch: 1,
                resourceId: '',
                resourcePath: '',
                identity: {
                    accessKey: '',
                    accountId: '',
                    apiKey: '',
                    apiKeyId: '',
                    caller: '',
                    clientCert: {
                        clientCertPem: '',
                        issuerDN: '',
                        serialNumber: '',
                        subjectDN: '',
                        validity: { notAfter: '', notBefore: '' },
                    },
                    cognitoAuthenticationProvider: '',
                    cognitoAuthenticationType: '',
                    cognitoIdentityId: '',
                    cognitoIdentityPoolId: '',
                    principalOrgId: '',
                    sourceIp: '',
                    user: '',
                    userAgent: '',
                    userArn: '',
                },

            },
            resource: ''
        };

        const result: APIGatewayProxyResult = await handler(event);

        expect(result.statusCode).toEqual(200);
        expect(result.body).not.toBeNull();

    })
})