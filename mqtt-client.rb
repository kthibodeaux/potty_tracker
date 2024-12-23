#!/usr/bin/env ruby
# frozen_string_literal: true

require 'mqtt'
require 'sequel'

DB = Sequel.connect ENV['DATABASE_URL']
MQTT_HOST = '10.1.20.1'
MQTT_PORT = 8005
MQTT_TOPIC = 'potty-tracker'

MQTT::Client.connect(MQTT_HOST, MQTT_PORT) do |c|
  c.get(MQTT_TOPIC) do |_, message|
    DB[:events].insert(event_type: message, timestamp: Time.now)
  end
end
