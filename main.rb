require 'dotenv/load'
require 'byebug'


require './src/robot'
require './src/api'
require './src/init'






def main
    puts "start"

    puts "init"
    puts "load env..."
    access_key = ENV['ACCESS_KEY']
    secret_key = ENV['SECRET_KEY']
    puts "ACCESS_KEY=#{access_key}"
    puts "SECRET_KEY=#{secret_key}"

    init = Init.new(access_key, secret_key)
    account_id = init.execute
    puts "account_id=#{account_id}"


    puts "end"
end

main

robot = Robot.new

robot.execute