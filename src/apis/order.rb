# frozen_string_literal: true

module Apis
  module Order
    ## 创建并执行一个新订单
    ## 如果使用借贷资产交易
    ## 请在下单接口/v1/order/orders/place
    ## 请求参数source中填写'margin-api'
    def new_order(symbol, side, price, count)
      params = {
        'account-id' => @account_id,
        'amount' => count,
        'price' => price,
        'source' => 'api',
        'symbol' => symbol,
        'type' => "#{side}-limit"
      }
      path = '/v1/order/orders/place'
      request_method = 'POST'
      util(path, params, request_method)
    end

    ## 申请提现虚拟币
    def withdraw_virtual_create(address, amount, currency)
      path = '/v1/dw/withdraw/api/create'
      params = {
        'address' => address,
        'amount' => amount,
        'currency' => currency
      }
      request_method = 'POST'
      util(path, params, request_method)
    end

    ## 申请取消提现虚拟币
    def withdraw_virtual_cancel(withdraw_id)
      path = "/v1/dw/withdraw-virtual/#{withdraw_id}/cancel"
      params = { 'withdraw_id' => withdraw_id }
      request_method = 'POST'
      util(path, params, request_method)
    end

    ## 查询某个订单详情
    def order_status(order_id, _market)
      path = "/v1/order/orders/#{order_id}"
      request_method = 'GET'
      params = { 'order-id' => order_id }
      util(path, params, request_method)
    end

    ## 申请撤销一个订单请求
    def submitcancel(order_id)
      path = "/v1/order/orders/#{order_id}/submitcancel"
      request_method = 'POST'
      params = { 'order-id' => order_id }
      util(path, params, request_method)
    end

    ## 批量撤销订单
    def batchcancel(order_ids)
      path = '/v1/order/orders/batchcancel'
      request_method = 'POST'
      params = { 'order-ids' => order_ids }
      util(path, params, request_method)
    end

    ## 查询某个订单的成交明细
    def matchresults(order_id)
      path = "/v1/order/orders/#{order_id}/matchresults"
      request_method = 'GET'
      params = { 'order-id' => order_id }
      util(path, params, request_method)
    end

    ## 查询当前委托、历史委托
    def open_orders(symbol, side)
      params = {
        'symbol' => symbol,
        'types' => "#{side}-limit",
        'states' => 'pre-submitted,submitted,partial-filled,partial-canceled'
      }
      path = '/v1/order/orders'
      request_method = 'GET'
      util(path, params, request_method)
    end

    ## 查询当前成交、历史成交
    def history_matchresults(symbol)
      path = '/v1/order/matchresults'
      params = { 'symbol' => symbol }
      request_method = 'GET'
      util(path, params, request_method)
    end

    ## 现货账户划入至借贷账户
    def transfer_in_margin(symbol, currency, amount)
      path = '/v1/dw/transfer-in/margin'
      params = { 'symbol' => symbol, 'currency' => currency, 'amount' => amount }
      request_method = 'POST'
      util(path, params, request_method)
    end

    ## 借贷账户划出至现货账户
    def transfer_out_margin(symbol, currency, amount)
      path = '/v1/dw/transfer-out/margin'
      params = { 'symbol' => symbol, 'currency' => currency, 'amount' => amount }
      request_method = 'POST'
      util(path, params, request_method)
    end

  end
end
