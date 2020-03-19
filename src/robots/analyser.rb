# frozen_string_literal: true

module Robots
  module Analyser
    class TrendLine
      class Stack
        def initalize()
          @inner = []
        end

        def push(e)
          @inner.push e
        end

        def pop
          @inner.pop
        end

        def at(idx)
          @inner.at idx
        end

        def all
          @inners
        end
      end

      attr_reader :down_stack, :up_stack

      def initialize(kline_result)
        @kline_result = kline_result
        @down_stack = Stack.new
        @up_stack = Stack.new
      end

      def go_down
        klines = @kline_result.turn_down_klines
        @down_stack.push(klines.first)
        klines[1..-1].each do |kline|
          # @down_stack
          # kline 
          # gradient_from
        end
         
          

      end

      def go_up

      end
    end

    class Kline
      attr_reader :klines, :result

      class Result
        attr_accessor :turn_klines, :turn_down_klines, :turn_up_klines

        def ready?
          not turn_klines.empty?
        end
      end

      def initialize(klines)
        @klines = klines.reverse
        @klines.each.with_index do |kline, idx|
          kline.idx = idx
        end
      end

      def execute
        return if empty?

        result = Result.new

        turn_klines = []
        turn_down_klines = []
        turn_up_klines = []

        do_first_kline!(turn_klines, turn_down_klines, turn_up_klines)
        do_rest_klines!(turn_klines, turn_down_klines, turn_up_klines)

        result.turn_klines = turn_klines
        result.turn_down_klines = turn_down_klines
        result.turn_up_klines = turn_up_klines
        result
      end

      def show_close_prices
        @klines.each do |kline|
          puts kline.close
        end
      end

      def show_open_prices
        @klines.each do |kline|
          puts kline.open
        end
      end

      def empty?
        @klines.empty?
      end

      private

      def do_first_kline!(turn_klines, turn_down_klines, turn_up_klines)
        first_kline = @klines.first

        if first_kline.down?
          turn_down_klines << first_kline
        else
          turn_up_klines << first_kline
        end
        turn_klines << first_kline

        [turn_klines, turn_down_klines, turn_up_klines]
      end

      def do_rest_klines!(turn_klines, turn_down_klines, turn_up_klines)
        prev_kline = @klines.first
        prev_trend = @klines.first.trend

        @klines[1..-1].each do |kline|
          trend = kline.trend_from(prev_kline)

          if trend != prev_trend
            if trend == :up
              turn_up_klines << kline
            elsif trend == :down
              turn_down_klines << kline
            end
            turn_klines << kline
          end

          prev_trend = trend
          prev_kline = kline
        end

        [turn_klines, turn_down_klines, turn_up_klines]
      end
    end
  end
end
