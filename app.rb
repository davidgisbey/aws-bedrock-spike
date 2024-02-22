require 'sinatra'
require 'pry'
require 'dotenv/load'
require "amazon_bedrock"

get '/ping' do
  'pong'
end

get '/query' do
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
