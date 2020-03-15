# frozen_string_literal: true

module Apis
  module Account
    #---account
    ## 查询当前用户的所有账户(即account-id)
    # {"status"=>"ok",
    #   "data"=>[
    #     {"id"=>12111111, "type"=>"spot", "subtype"=>"", "state"=>"working"}]}
    def accounts
      path = '/v1/account/accounts'
      request_method = 'GET'
      params = {}
      json = util(path, params, request_method)
    end

    ## 获取账户资产状况
    def balances
      path = "/v1/account/accounts/#{@account_id}/balance"
      request_method = 'GET'
      # balances = {"account_id"=>@account_id}
      util(path, {}, request_method)
    end

  end
end
