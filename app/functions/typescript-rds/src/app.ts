import { Context, APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda';

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const handler = async (event: APIGatewayEvent): Promise<APIGatewayProxyResult> => {

    const user = await prisma.user.create({
        data: {
            name: 'Alice',
            email: 'alice@prisma.io'
        }
    });

    console.log(user)

    return {
        statusCode: 200,
        body: JSON.stringify({
            message: 'hello wolrd'
        })
    }
}