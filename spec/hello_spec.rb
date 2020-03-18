# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'hello' do
  context 'just test' do
    it 'test it' do
      expect('hello').to eq 'hello'
    end
  end
end
