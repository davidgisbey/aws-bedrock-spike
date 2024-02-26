require 'sinatra'
require 'dotenv/load'
require "amazon_bedrock"

get '/query' do
  query = params[:query]

  client = RubyAmazonBedrock::Client.new(
    region: ENV['REGION'],
    access_key_id: ENV['ACCESS_KEY_ID'],
    secret_access_key: ENV['SECRET_ACCESS_KEY']
  )

  client.invoke_model(
    id: ENV['MODEL_ID'],
    prompt: query,
  )[:text]
end
