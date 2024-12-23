#!/usr/bin/env ruby

require 'mqtt'

MQTT_HOST = '10.1.20.1'
MQTT_PORT = 8005
MQTT_TOPIC = 'potty-tracker'

MQTT::Client.connect(MQTT_HOST, MQTT_PORT) do |c|
  c.get(MQTT_TOPIC) do |_, message|
    File.open('data/potty-tracker.log', 'a') do |f|
      f.puts "#{Time.now},#{message}"
    end
  end
end
