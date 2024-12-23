# frozen_string_literal: true

require 'sequel'

DB = Sequel.connect ENV['DATABASE_URL']

DB.create_table? :events do
  primary_key :id
  String :event_type, null: false
  DateTime :timestamp, null: false
end
