# fastify-app

---

## Layer

```
zipit/
└── nodejs/
└── node_modules/
├── package1/
└── package2/
```

```sh
mkdir -p layer/nodejs/node_modules
cd layer/nodejs
pnpm init
pnpm add install fastify fastify-aws-lambda
cd ..
zip -r fastify-layer.zip nodejs
```

```sh
aws lambda publish-layer-version --layer-name fastify-layer --zip-file fileb://fastify-layer.zip --compatible-runtimes nodejs20.x nodejs18.x nodejs16.x nodejs14.x
```

---

## App

- zip the app

```sh
zip -r fastify-app.zip app.js lambda.js
```

- push it to lambda with aws cli

```sh
aws lambda create-function \
    --function-name myFastifyFunction \
    --runtime nodejs20.x \
    --role arn:aws:iam::851725517932:role/lambda-full-access \
    --handler lambda.handler \
    --zip-file fileb://fastify-app.zip \
    --layers arn:aws:lambda:us-east-1:851725517932:layer:fastify-layer:2 arn:aws:lambda:us-east-1:851725517932:layer:fastify-aws-lambda-layer:1
```

## Update the source, zip and lambda with cli

- update the zip archive with the new source (delete the old archive first and then recreate it; there may be a better way but this is cleaner)

```sh
rm fastify-app.zip

zip -r fastify-app.zip app.js lambda.js
```

- update the lambda function with the new zip archive

```sh
aws lambda update-function-code --function-name myFastifyFunction --zip-file fileb://fastify-app.zip
```
