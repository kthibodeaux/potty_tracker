#!/usr/bin/env ruby

require 'mqtt'

MQTT_HOST = '10.1.20.1'
MQTT_PORT = 8005
MQTT_TOPIC = 'potty-tracker'

def log(action)
  File.open('data/potty-tracker.log', 'a') do |f|
    f.puts "#{Time.now},#{action}"
  end
end

MQTT::Client.connect(MQTT_HOST, MQTT_PORT) do |c|
  c.get(MQTT_TOPIC) do |_, message|
    case message
    when 'accident'
      log :accident
    when 'poop'
      log :poop
    when 'pee'
      log :pee
    when 'poop and pee'
      log :poop and pee
    when 'attempt'
      log :attempt
    end
  end
end
