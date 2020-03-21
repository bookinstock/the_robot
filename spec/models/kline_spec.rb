# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../src/models/kline'

RSpec.describe 'kline' do
  describe 'klines builder' do
    it 'example' do
      raw_klines = [
        {
          "open"=>1,
          "close"=>2
        },
        {
          "open"=>2,
          "close"=>3
        }
      ]

      builder = Models::KlinesBuilder.new(raw_klines)

      klines = builder.execute()
      k1, k2 = klines

      expect(klines.size).to eq 2
      expect(k1.idx).to eq 0
      expect(k1.open).to eq 2
      expect(k1.close).to eq 3
      expect(k2.idx).to eq 1
      expect(k2.open).to eq 1
      expect(k2.close).to eq 2
    end
  end
end