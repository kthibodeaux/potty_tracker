# frozen_string_literal: true

require 'sinatra'
require 'sequel'
require 'json'

# Connect to the PostgreSQL database
DB = Sequel.connect ENV['DATABASE_URL']

set :bind, '0.0.0.0'

get '/events' do
  content_type :json
  events = DB[:events].all
  events.to_json
end
