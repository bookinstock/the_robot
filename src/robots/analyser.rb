# frozen_string_literal: true

module Robots
  module Analyser
    class Trend
      def initialize(klines)
        @klines = klines
      end

      def execute
        prev = @klines.first

        @klines[1..-1].each do |kline|
          puts "#{kline.time}-(#{kline.open}~#{kline.close})"
          if prev.up?
            if kline.close > prev.open
              # puts :trend_keep_up
              puts "拿住"
            else
              # puts :trend_turn_down
              puts "卖"
            end
          else
            if kline.close < prev.open
              # puts :trend_keep_down
              puts "忍住"
            else
              # puts :trend_turn_up
              puts "买"
            end
          end
        end
      end

      def update(kline)

      end
    end

    class TrendLine
      attr_reader :down_stack, :up_stack

      def initialize(kline_result)
        @kline_result = kline_result
        @down_stack = []
        @up_stack = []
      end

      # down down down
      def go_down
        klines = @kline_result.turn_down_klines
        @down_stack << klines.first

        puts "--#{klines.first.idx}=#{klines.first.open}"

        klines[1..-1].each do |kline|
          go_down_recursion(kline)
        end

        @down_stack
      end

      # up up up
      def go_up
        klines = @kline_result.turn_up_klines
        @up_stack << klines.first

        puts "-【#{klines.first.time}】-#{klines.first.idx}=#{klines.first.open}"

        klines[1..-1].each do |kline|
          go_up_recursion(kline)
        end

        @up_stack
      end

      private

      def go_down_recursion(kline)
        puts "-【#{kline.time}】-#{kline.idx}=#{kline.open}"

        raise('down_stack size can not be zero!!!') if @down_stack.size.zero?

        # when only 1 element in the stack
        if @down_stack.size == 1
          if kline.open > @down_stack.first.open
            k = @down_stack.pop
            puts "下降趋势逆转逆转:#{k.open}->#{kline.open}"
            @down_stack << kline
            # 趋势完全突破
          else
            @down_stack << kline
          end
          return
        end

        if @down_stack.size > 1
          prev_gradient = @down_stack[-1].gradient_from(kline)
          curr_gradient = @down_stack[-2].gradient_from(kline)

          if curr_gradient > prev_gradient
            @down_stack << kline
            nil
          else
            k = @down_stack.pop
            puts "下降趋势线更新:#{k.open}->#{kline.open}(prev=#{prev_gradient},current=#{curr_gradient})"

            go_down_recursion(kline)
          end
        end
      end

      def go_up_recursion(kline)
        puts "--#{kline.idx}=#{kline.open}"

        raise('up_stack size can not be zero!!!') if @up_stack.size.zero?

        # when only 1 element in the stack
        if @up_stack.size == 1
          if kline.open <= @up_stack.first.open
            k = @up_stack.pop
            puts "上升趋势逆转:#{k.open}->#{kline.open}"
            @up_stack << kline
            # 趋势完全突破
          else
            @up_stack << kline
          end
          return
        end

        if @up_stack.size > 1
          prev_gradient = @up_stack[-1].gradient_from(kline)
          curr_gradient = @up_stack[-2].gradient_from(kline)

          if curr_gradient <= prev_gradient
            @up_stack << kline
            nil
          else
            k = @up_stack.pop
            puts "下降趋势线更新:#{k.open}->#{kline.open}(prev=#{prev_gradient},current=#{curr_gradient})"

            go_up_recursion(kline)
          end
        end
      end
    end

    class Kline
      attr_reader :klines, :result

      class Result
        attr_accessor :turn_klines, :turn_down_klines, :turn_up_klines

        def ready?
          !turn_klines.empty?
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
