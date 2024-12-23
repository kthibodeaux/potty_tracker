#!/usr/bin/env ruby
# frozen_string_literal: true

require 'mqtt'
require 'sequel'

DB = Sequel.connect ENV['DATABASE_URL']
MQTT_HOST = ENV['MQTT_HOST']
MQTT_PORT = ENV['MQTT_PORT']
MQTT_TOPIC = ENV['MQTT_TOPIC']

MQTT::Client.connect(MQTT_HOST, MQTT_PORT) do |c|
  c.get(MQTT_TOPIC) do |_, message|
    DB[:events].insert(event_type: message, timestamp: Time.now)
  end
end
