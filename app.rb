require 'sinatra'
require 'pry'
require 'dotenv/load'
require "amazon_bedrock"
require 'aws-sdk-bedrockruntime'

get '/ping' do
  'pong'
end

get '/query' do
  query = params[:query]

  client = Aws::BedrockRuntime::Client.new(
    region: ENV['REGION'],
    access_key_id: ENV['ACCESS_KEY_ID'],
    secret_access_key: ENV['SECRET_ACCESS_KEY']
  )

  aws_response = client.invoke_model(
    model_id: 'amazon.titan-text-express-v1',
    content_type: 'application/json',
    accept: '*/*',
    body: {
      inputText: query,
      # you would want to make these configurable, but for simplicity hardcoded them here.
      textGenerationConfig: {
        maxTokenCount: 4096,
        stopSequences: [],
        temperature: 0,
        topP: 1
      }
    }.to_json
  )

  JSON.parse(aws_response.body.read)["results"].first["outputText"]
end

get '/query-with-ruby-amazon-bedrock' do
  query = params[:query]

  client = RubyAmazonBedrock::Client.new(
    region: ENV['REGION'],
    access_key_id: ENV['ACCESS_KEY_ID'],
    secret_access_key: ENV['SECRET_ACCESS_KEY']
  )

  client.invoke_model(
    id: 'amazon.titan-text-express-v1',
    prompt: query,
  )[:text]
end
