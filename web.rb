# frozen_string_literal: true

require 'active_support/time'
require 'sinatra'
require 'sequel'

DB = Sequel.connect ENV['DATABASE_URL']
TIMEZONE = 'America/New_York'

set :bind, '0.0.0.0'

def get_utc_range(raw_date)
  date = raw_date.in_time_zone(TIMEZONE)
  date.beginning_of_day.in_time_zone('UTC')..date.end_of_day.in_time_zone('UTC')
end

get '/' do
  raw_date = params[:date] ? Date.parse(params[:date]) : Date.today
  range = get_utc_range(raw_date)

  @local_date = raw_date.in_time_zone(TIMEZONE)
  @events = DB[:events].order(:timestamp).where(timestamp: range).all

  slim :index
end
