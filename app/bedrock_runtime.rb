require 'sinatra'
require 'dotenv/load'
require 'aws-sdk-bedrockruntime'

client = Aws::BedrockRuntime::Client.new(
  region: ENV['REGION'],
  access_key_id: ENV['ACCESS_KEY_ID'],
  secret_access_key: ENV['SECRET_ACCESS_KEY']
)

get '/query' do
  query = params[:query]

  aws_response = client.invoke_model(
    model_id: 'amazon.titan-text-express-v1',
    content_type: 'application/json',
    accept: '*/*',
    body: {
      inputText: query,
      # you would want to make these configurable, but for simplicity i've hardcoded them here.
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

get '/get-embedding' do
  query = params[:query]

  aws_response = client.invoke_model(
  model_id: "amazon.titan-embed-text-v1",
  content_type: 'application/json',
  accept: '*/*',
  body: {
    inputText: query,
  }.to_json
)
  JSON.parse(aws_response.body.read)["embedding"].to_s
end
