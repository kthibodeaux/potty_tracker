# frozen_string_literal: true

require 'active_support/time'
require 'sinatra'
require 'sequel'

DB = Sequel.connect ENV['DATABASE_URL']
TIMEZONE = 'America/New_York'

set :bind, '0.0.0.0'

get '/' do
  raw_date = params[:date] ? Date.parse(params[:date]) : Date.today
  @date = raw_date.in_time_zone(TIMEZONE)

  utc_start = @date.beginning_of_day.getlocal('+00:00')
  utc_end = @date.end_of_day.getlocal('+00:00')

  @events = DB[:events].order(:timestamp).where(timestamp: utc_start..utc_end).all
  slim :index
end
