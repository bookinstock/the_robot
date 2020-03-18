# frozen_string_literal: true

module Robots
  module Analyser
    # class Base
    #     def initialize()
    #     end
    #   end
    # end


    class Kline
      attr_reader :klines, :start_kline, :turn_klines, 
        :turn_up_klines, :turn_down_klines

      def initialize(klines)
        @klines = klines.reverse
      end

      def show_close_prices
        @klines.each do |e|
          puts e.close
        end
      end

      def execute
        start_kline = nil

        turn_down_klines = []

        turn_up_klines = []


        prev_trend = nil
        prev_kline = nil
        klines.reverse.each_with_index do |kline, idx|
          if prev_kline.nil?
            "first"
            prev_kline = kline
            puts "-#{idx}:first-#{kline.close}"

            start_kline = kline

            if start_kline.open < start_kline.close
              turn_down_klines << [idx, kline]
            else
              turn_up_klines << [idx, kline]
            end

            next
          end

          trend = if kline.close < prev_kline.close
                    :down
                  else
                    :up
                  end

          if prev_trend.nil?
            "second"
            prev_trend = trend
            msg = "--#{trend}--#{kline.close}"
            puts "-#{idx}:#{msg}"

            next
          end

          # trend not change
          msg =
            if trend == prev_trend
              if trend == :down
                "--down--#{kline.close}"
              elsif trend == :up
                "--up--#{kline.close}"
              else
                '!!!wtf1'
              end
            else # trend change
              if trend == :up
                "change!-up-#{kline.close}"

                turn_up_klines << [idx, kline]
              elsif trend == :down
                "change!-down-#{kline.close}"

                turn_down_klines << [idx, kline]
              else
                '!!!wtf2'
              end
            end

          puts "-#{idx}:#{msg}"

          prev_trend = trend
          prev_kline = kline
        end

      end
    end
  end
end
