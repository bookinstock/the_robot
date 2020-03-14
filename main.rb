require 'dotenv/load'


require './robot'
require './api'


def main
    puts "init.."

    puts "ACCESS_KEY=#{ENV['ACCESS_KEY']}"
    puts "SECRET_KEY=#{ENV['SECRET_KEY']}"

    puts ENV['XXXXX']
end

main

robot = Robot.new

robot.execute