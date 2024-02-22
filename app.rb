require 'sinatra'
require 'pry'
require 'dotenv/load'

get '/ping' do
  'pong'
end
