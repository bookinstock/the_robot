# frozen_string_literal: true

require_relative 'analyser'

require 'byebug'

module Robots
  class Simulator
    FEE_RATE = 0.002

    def initialize(klines)
      puts "from #{klines.last.time}"
      puts "to #{klines.first.time}"
      puts "kines count=#{klines.size}"
      @klines = klines
    end

    def strategy_1
      analyser = Robots::Analyser::Strategy1.new(@klines)
      results = analyser.execute
      check(results)
    end

    def strategy_2
      analyser = Robots::Analyser::Strategy2.new(@klines)
      results = analyser.execute
      check(results)
    end

    private

    def check(results)
      puts "results_count=#{results.size}"

      out_money = 10_000
      in_money = 0

      if results.empty?
        puts 'do nothing'
        return
      end

      prev_buy_k = nil
      results.each do |result|
        if result.action == :buy
          if out_money > 0
            k = result.kline
            fee = FEE_RATE * out_money

            in_money = out_money - fee
            out_money = 0
            puts "buy - price=#{k.close},in_money=#{in_money},out_money=#{out_money},fee=#{fee}"
            prev_buy_k = k
          end
        end

        if result.action == :sell
          if in_money > 0 && prev_buy_k
            k = result.kline
            fee = FEE_RATE * in_money

            price_diff = k.close - prev_buy_k.close
            ratio_diff = price_diff * 1.0 / prev_buy_k.close
            money_diff = in_money * ratio_diff
            in_money += money_diff
            out_money = in_money - fee
            in_money = 0
            puts "sell - price=#{k.close},in_money=#{in_money},out_money=#{out_money},fee=#{fee}(price_diff=#{price_diff}),ratio_diff=#{ratio_diff},money_diff=#{money_diff}"
            prev_buy_k = nil
          end
        end
      end
    end
  end
end
