# frozen_string_literal: true

module Apis
  module Margin
    ## 借贷订单
    def loan_orders(symbol, currency)
      path = '/v1/margin/loan-orders'
      params = { 'symbol' => symbol, 'currency' => currency }
      request_method = 'POST'
      util(path, params, request_method)
    end

    ## 归还借贷
    def repay(order_id, amount)
      path = '/v1/margin/orders/{order-id}/repay'
      params = { 'order-id' => order_id, 'amount' => amount }
      request_method = 'GET'
      util(path, params, request_method)
    end

    ## 借贷账户详情
    def margin_accounts_balance(_symbol)
      path = '/v1/margin/accounts/balance?symbol={symbol}'
      params = {}
      request_method = 'GET'
      util(path, params, request_method)
    end

    ## 申请借贷
    def margin_orders(symbol, currency, amount)
      path = '/v1/margin/orders'
      params = { 'symbol' => symbol, 'currency' => currency, 'amount' => amount }
      request_method = 'POST'
      util(path, params, request_method)
    end
  end
end
