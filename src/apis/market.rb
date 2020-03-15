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

    def market_klines(symbol, period, size = 150)
      path = '/market/history/kline'
      request_method = 'GET'
      params = { 'symbol' => symbol, 'period' => period, 'size' => size }
      util(path, params, request_method)
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