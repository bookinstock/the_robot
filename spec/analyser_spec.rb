require_relative 'spec_helper'
require_relative '../src/models/kline'
require_relative '../src/robots/analyser'

RSpec.describe 'analyser' do
  context "klines" do
    before(:example) do
      data = [{"amount"=>619.3034099946908,
        "open"=>5363.03,
        "close"=>5324.98,
        "high"=>5372.27,
        "id"=>1584542700,
        "count"=>3662,
        "low"=>5315.44,
        "vol"=>3310011.24424278},
       {"amount"=>1746.621948323623,
        "open"=>5330.88,
        "close"=>5363.02,
        "high"=>5375.0,
        "id"=>1584541800,
        "count"=>10310,
        "low"=>5318.5,
        "vol"=>9337528.878822388},
       {"amount"=>1601.6863071289633,
        "open"=>5365.12,
        "close"=>5330.88,
        "high"=>5379.0,
        "id"=>1584540900,
        "count"=>8700,
        "low"=>5297.28,
        "vol"=>8543547.848085703},
       {"amount"=>3424.892319579545,
        "open"=>5338.64,
        "close"=>5366.0,
        "high"=>5385.0,
        "id"=>1584540000,
        "count"=>18016,
        "low"=>5300.01,
        "vol"=>18322816.65707355},
       {"amount"=>3998.7522974410435,
        "open"=>5214.95,
        "close"=>5337.34,
        "high"=>5380.0,
        "id"=>1584539100,
        "count"=>21453,
        "low"=>5192.98,
        "vol"=>21205114.4895674},
       {"amount"=>7339.38324966166,
        "open"=>5160.09,
        "close"=>5214.78,
        "high"=>5280.0,
        "id"=>1584538200,
        "count"=>26305,
        "low"=>5100.0,
        "vol"=>38225175.2884537},
       {"amount"=>3174.160273385421,
        "open"=>5075.43,
        "close"=>5160.09,
        "high"=>5200.0,
        "id"=>1584537300,
        "count"=>14970,
        "low"=>5010.0,
        "vol"=>16120765.467146443},
       {"amount"=>628.5184817831317,
        "open"=>5112.02,
        "close"=>5075.58,
        "high"=>5112.83,
        "id"=>1584536400,
        "count"=>4520,
        "low"=>5071.0,
        "vol"=>3198780.836202033},
       {"amount"=>497.8182924480013,
        "open"=>5125.97,
        "close"=>5113.81,
        "high"=>5129.45,
        "id"=>1584535500,
        "count"=>4206,
        "low"=>5096.32,
        "vol"=>2545253.8235769444},
       {"amount"=>668.8171413545598,
        "open"=>5101.15,
        "close"=>5127.22,
        "high"=>5140.22,
        "id"=>1584534600,
        "count"=>5184,
        "low"=>5090.01,
        "vol"=>3420375.8741301564}]

      @klines = data.map { |e| Models::Kline.new(e) }

      @analyser = Robots::Analyser::Kline.new(@klines)

      @analyser.execute
    end

    it "find trun_klines" do
      turn_klines = @analyser.turn_klines

      expect(turn_klines.size).to eq 1
    end

    it "find turn_down_klines" do
      turn_up_klines = @analyser.turn_down_klines

      expect(turn_up_klines.size).to eq 1
    end

    it "find turn_up_klines" do
      turn_up_klines = @analyser.turn_up_klines

      expect(turn_up_klines.size).to eq 1
    end
  end
end

