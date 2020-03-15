module Apis
  module Common
    def common_symbols
      path = '/v1/common/symbols'
      request_method = 'GET'
      params = {}
      util(path, params, request_method)
    end

    def common_currencys
      path = '/v1/common/currencys'
      request_method = 'GET'
      params = {}
      util(path, params, request_method)
    end
  end
end