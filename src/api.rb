# frozen_string_literal: true

require 'httparty'
require 'json'
require 'open-uri'
require 'rack'
require 'digest/md5'
require 'base64'

require 'byebug'

require_relative 'apis/account'
require_relative 'apis/common'
require_relative 'apis/market'
require_relative 'apis/margin'
require_relative 'apis/order'

class Api
  include Apis::Account
  include Apis::Common
  include Apis::Market
  include Apis::Margin
  include Apis::Order

  attr_accessor :access_key, :secret_key, :account_id

  def initialize(access_key, secret_key, account_id, signature_version = '2')
    @access_key = access_key
    @secret_key = secret_key
    @signature_version = signature_version
    @account_id = account_id
    @uri = URI.parse 'https://api.huobi.pro/'
    @header = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json',
      'Accept-Language' => 'zh-CN',
      'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36'
    }
  end

  private

  def util(path, params, request_method)
    h = {
      'AccessKeyId' => @access_key,
      'SignatureMethod' => 'HmacSHA256',
      'SignatureVersion' => @signature_version,
      'Timestamp' => Time.now.getutc.strftime('%Y-%m-%dT%H:%M:%S')
    }
    h = h.merge(params) if request_method == 'GET'
    data = "#{request_method}\napi.huobi.pro\n#{path}\n#{Rack::Utils.build_query(hash_sort(h))}"
    h['Signature'] = sign(data)
    url = "https://api.huobi.pro#{path}?#{Rack::Utils.build_query(h)}"

    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    begin
      JSON.parse http.send_request(request_method, url, JSON.dump(params), @header).body
    rescue Exception => e
      { 'message' => 'error', 'request_error' => e.message }
    end
  end

  def sign(data)
    Base64.encode64(OpenSSL::HMAC.digest('sha256', @secret_key, data)).gsub("\n", '')
  end

  def hash_sort(ha)
    Hash[ha.sort_by { |key, _val| key }]
  end
end

# client = Api.new(access_key,secret_key,account_id)

# # account = client.accounts

# # account_id = 12163165

# p client.balances
# # p client.symbols
# # p client.depth('ethbtc')
# # p client.history_kline('ethbtc',"1min")
# # p client.merged('ethbtc')
# # p client.trade_detail('ethbtc')
# # p client.history_trade('ethbtc')
