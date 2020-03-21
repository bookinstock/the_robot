# frozen_string_literal: true

require 'virtus'

module Models
  class Kline
    include Virtus.model

    attr_accessor :idx

    attribute :id, Integer
    attribute :open, Float
    attribute :close, Float
    attribute :high, Float
    attribute :low, Float
    attribute :amount, Float
    attribute :vol, Float
    attribute :count, Integer

    def time
      Time.at(id)
    end

    def up?
      open < close
    end

    def down?
      !up?
    end

    def trend
      if up?
        :up
      else
        :down
      end
    end

    def trend_from(prev)
      if prev.close > close
        :down
      else
        :up
      end
    end

    def ratio_from(prev)
      ratio = (open - prev.open) / (idx - prev.idx)
      ratio.abs
    end
  end

  class KlinesBuilder
    def initialize(raw_klines)
      @raw_klines = raw_klines
    end

    def execute(reverse: true)
      klines = @raw_klines.map { |e| Models::Kline.new(e) }
      klines = klines.reverse if reverse
      klines.each_with_index { |k, idx| k.idx = idx }
      klines
    end
  end
end

# {"amount"=>12.34164194163555,
#     "open"=>5207.84,
#     "close"=>5205.47,
#     "high"=>5208.66,
#     "id"=>1584246660,
#     "count"=>52,
#     "low"=>5205.47,
#     "vol"=>64272.31202248}
