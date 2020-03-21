# frozen_string_literal: true

require_relative '../models/kline'

module Apis
  module Market
    def market_depth(symbol, type = 'step0')
      path = '/market/depth'
      request_method = 'GET'
      params = { 'symbol' => symbol, 'type' => type }
      util(path, params, request_method)
    end

    def market_depths(symbol)
      path = '/market/depth'
      request_method = 'GET'
      params = { 'symbol' => symbol }
      util(path, params, request_method)
    end

    # symbol => btcusdt, ethbtc...
    # period => 1min, 5min, 15min, 30min, 60min, 4hour, 1day, 1mon, 1week, 1year
    # size => 0..2000
    def market_klines(symbol = 'btcusdt', period = '15min', size = 100)
      path = '/market/history/kline'
      request_method = 'GET'
      params = { 'symbol' => symbol, 'period' => period, 'size' => size }
      response = util(path, params, request_method)
      klines = response['data'].map { |e| Models::Kline.new(e) }
      klines.reverse
    end

    def market_ticker(symbol)
      path = '/market/detail/merged'
      request_method = 'GET'
      params = { 'symbol' => symbol }
      util(path, params, request_method)
    end

    def market_trade(symbol)
      path = '/market/trade'
      request_method = 'GET'
      params = { 'symbol' => symbol }
      util(path, params, request_method)
    end

    def market_trades(symbol, size = 1)
      path = '/market/history/trade'
      request_method = 'GET'
      params = { 'symbol' => symbol, 'size' => size }
      util(path, params, request_method)
    end

    def market_detail(symbol)
      path = '/market/detail'
      request_method = 'GET'
      params = { 'symbol' => symbol }
      util(path, params, request_method)
    end
  end
end
