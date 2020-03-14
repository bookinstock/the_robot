require_relative 'api'

require 'byebug'

class Init
    attr_accessor :access_key, :secret_key, :api

    def initialize(access_key, secret_key)
        @access_key = access_key
        @secret_key = secret_key

        @api = Api.new(access_key, secret_key, nil)
    end

    def execute
        accounts = @api.accounts()
        account_ids = accounts['data'].select {|e| e['state'] == 'working'}.map {|e| e['id']}
        account_id = account_ids.first
    end
end

