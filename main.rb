# frozen_string_literal: true

require 'byebug'
require 'dotenv/load'
require 'virtus'
require 'redis-objects'
require 'connection_pool'
Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) do
  Redis.new(host: '127.0.0.1', port: 6379)
end

require './src/robot'
require './src/api'
require './src/init'

access_key = ENV['ACCESS_KEY']
secret_key = ENV['SECRET_KEY']
account_id = ENV['ACCOUNT_ID']

api = Api.new(access_key, secret_key, account_id)


# default => symbol='btcusdt', period='15min', size = 100
klines = api.market_klines

# store in redis
list = Redis::List.new('klans', marshal: true)
list.clear
klines.each do |kline|
  list << kline
end


puts "from #{klines.first.time} to #{klines.last.time}"





#TODO find trend change point
prev_trend = nil
prev_kline = nil
klines.each_with_index do |kline, idx|
  if prev_kline
    if prev_kline.close > kline.open
      trend = :down
    else
      trend = :up
    end
  end

  # trend not change
  msg =
    if trend == prev_kline
      if prev_trend == :down
        "--up--#{kline.close}"
      elsif prev_trend == :up
        "--down--#{kline.close}"
      else
        "!!!wtf"
      end
    else # trend change
      if prev_trend == :down && trend == :up
        "change!-up-#{kline.close}"
      elsif prev_trend == :up && trend == :down
        "change!-down-#{kline.close}"
      else
        if prev_trend == nil
          "start-#{kline.close}"
        elsif trend == nil
          "end-#{kline.close}"
        else
          "!!!wtf2"
        end
      end
    end

  puts "-#{idx}:#{msg}"

  prev_trend = trend
  prev_kline = kline
end

### separate


def main
  puts 'start'

  puts 'init'
  puts 'load env...'
  access_key = ENV['ACCESS_KEY']
  secret_key = ENV['SECRET_KEY']
  account_id = ENV['ACCOUNT_ID']

  puts '======'
  puts "ACCESS_KEY=#{access_key}"
  puts "SECRET_KEY=#{secret_key}"
  puts "account_id=#{account_id}"
  puts '======'

  if account_id
    api = Api.new(access_key, secret_key, account_id)
  else
    init = Init.new(access_key, secret_key)
    api = init.execute
  end




  # accountmodule
  # accounts

  # balances

  # history

  debugger

  # api.symbols
  # {"base-currency"=>"pay", "quote-currency"=>"eth", "price-precision"=>8, "amount-precision"=>2, "symbol-partition"=>"innovation", "symbol"=>"payeth", "state"=>"online", "value-precision"=>8, "min-order-amt"=>0.1, "max-order-amt"=>500000, "min-order-value"=>0.01}

  puts 'end'
end

# main

# robot = Robot.new

# robot.execute
