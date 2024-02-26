# Ruby Amazon Bedrock spike

## Add env variables
cp .env_sample .env

## install dependencies
bundle install

## run the server for the Aws::BedrockRuntime implentation
ruby app/bedrock_runtime.rb

## Or run the server for the ruby amazon bedrock gems implentation
ruby app/ruby_amazon_bedrock.rb

## visit the server with your question as a query param
http://localhost:4567/query?query=What is the capital of Germany?
