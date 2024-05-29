aws lambda create-function \
    --function-name zipit \
    --runtime nodejs20.x \
    --role arn:aws:iam::851725517932:role/lambda-full-access \
    --handler app.lambdaHandler \
    --zip-file fileb://zipit.zip \
    --layers arn:aws:lambda:us-east-1:851725517932:layer:fastify-layer:2 arn:aws:lambda:us-east-1:851725517932:layer:fastify-aws-lambda-layer:1