# frozen_string_literal: true

require 'byebug'
require_relative 'spec_helper'
require_relative '../src/models/kline'
require_relative '../src/robots/analyser'

RSpec.describe 'analyser' do
  describe 'strategy 1' do
    describe 'only one kline' do
      it 'one up' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 2
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'one down' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end
    end

    describe 'two klines' do
      it 'two perfect up' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'two perfect down' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'two overlap up' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 3
          },
          {
            'open' => 2,
            'close' => 4
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'two overlap down' do
        raw_klines = [
          {
            'open' => 4,
            'close' => 2
          },
          {
            'open' => 3,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'one big up and one little down' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 2
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'one big down and one little up' do
        raw_klines = [
          {
            'open' => 4,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'one up and one down' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.kline.idx).to eq 1
        expect(r1.action).to eq :sell
      end

      it 'one down and one up' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 1
          },
          {
            'open' => 1,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.kline.idx).to eq 1
        expect(r1.action).to eq :buy
      end

      it 'one little up and one big down' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.kline.idx).to eq 1
        expect(r1.action).to eq :sell
      end

      it 'one little down and one big up' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 1
          },
          {
            'open' => 1,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.kline.idx).to eq 1
        expect(r1.action).to eq :buy
      end
    end

    describe 'more' do
      it 'up up up up' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          },
          {
            'open' => 3,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 5
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'down down down down' do
        raw_klines = [
          {
            'open' => 5,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'little down in ups' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 5
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'little up in downs' do
        raw_klines = [
          {
            'open' => 5,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 2
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'two little downs in ups' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 6
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'two little ups in downs' do
        raw_klines = [
          {
            'open' => 6,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 2
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'two downs in ups' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.kline.idx).to eq 2
        expect(r1.action).to eq :sell
      end

      it 'two ups in downs' do
        raw_klines = [
          {
            'open' => 6,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 6
          },
          {
            'open' => 6,
            'close' => 5
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.kline.idx).to eq 2
        expect(r1.action).to eq :buy
      end

      it 'two big downs in ups' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 1
          },
          {
            'open' => 1,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.kline.idx).to eq 2
        expect(r1.action).to eq :sell
      end

      it 'two big ups in downs' do
        raw_klines = [
          {
            'open' => 6,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 7
          },
          {
            'open' => 7,
            'close' => 5
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.kline.idx).to eq 2
        expect(r1.action).to eq :buy
      end

      it 'up down up down' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 6
          },
          {
            'open' => 6,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1, r2, r3 = results

        expect(results.size).to eq 3
        expect(r1.kline.idx).to eq 1
        expect(r1.action).to eq :sell
        expect(r2.kline.idx).to eq 2
        expect(r2.action).to eq :buy
        expect(r3.kline.idx).to eq 3
        expect(r3.action).to eq :sell
      end

      it 'down up down up' do
        raw_klines = [
          {
            'open' => 5,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 6
          },
          {
            'open' => 6,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 10
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy1.new(klines)

        results = analyser.execute
        r1, r2, r3 = results

        expect(results.size).to eq 3
        expect(r1.kline.idx).to eq 1
        expect(r1.action).to eq :buy
        expect(r2.kline.idx).to eq 2
        expect(r2.action).to eq :sell
        expect(r3.kline.idx).to eq 3
        expect(r3.action).to eq :buy
      end
    end
  end

  describe 'strategy 2' do
    describe 'only one kline' do
      it 'one up' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 2
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'one down' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end
    end

    describe 'two' do
      it 'up up' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'down down' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'up down' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'down up' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end
    end

    describe 'three' do
      it 'up down up' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 1
          },
          {
            'open' => 1,
            'close' => 2
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'down up down' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end
    end

    describe 'more' do
      it 'up down up down' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 1
          },
          {
            'open' => 1,
            'close' => 2
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'down up down up' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'up trend -> up down up down up' do
        raw_klines = [
          {
            'open' => 1,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 5
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'down trend -> up down up down up (not break)' do
        raw_klines = [
          {
            'open' => 6,
            'close' => 7
          },
          {
            'open' => 7,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 6
          },
          {
            'open' => 6,
            'close' => 1
          },
          {
            'open' => 1,
            'close' => 2
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'down trend -> up down up down up (break)' do
        raw_klines = [
          {
            'open' => 6,
            'close' => 7
          },
          {
            'open' => 7,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 6
          },
          {
            'open' => 6,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 6
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.action).to eq :buy
        expect(r1.kline.idx).to eq 4
      end

      it 'down trend -> up down up (higher) down up (break)' do
        raw_klines = [
          {
            'open' => 6,
            'close' => 7
          },
          {
            'open' => 7,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 6
          },
          {
            'open' => 6,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 10
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.action).to eq :buy
        expect(r1.kline.idx).to eq 4
      end

      it 'down trend -> down up down up down' do
        raw_klines = [
          {
            'open' => 6,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'up trend -> down up down up down (not break)' do
        raw_klines = [
          {
            'open' => 2,
            'close' => 1
          },
          {
            'open' => 1,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute

        expect(results).to eq []
      end

      it 'up trend -> down up down up down (break)' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.action).to eq :sell
        expect(r1.kline.idx).to eq 4
      end

      it 'down trend -> up down up (higher) down up (break)' do
        raw_klines = [
          {
            'open' => 3,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 1
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute
        r1 = results.first

        expect(results.size).to eq 1
        expect(r1.action).to eq :sell
        expect(r1.kline.idx).to eq 4
      end

      it 'complex' do
        raw_klines = [
          {
            'open' => 7,
            'close' => 8
          },
          {
            'open' => 8,
            'close' => 6
          },
          {
            'open' => 6,
            'close' => 7
          },
          {
            'open' => 7,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 1
          },
          {
            'open' => 1,
            'close' => 5
          },
          {
            'open' => 5,
            'close' => 4
          },
          {
            'open' => 4,
            'close' => 3
          },
          {
            'open' => 3,
            'close' => 7
          },
          {
            'open' => 7,
            'close' => 2
          },
          {
            'open' => 2,
            'close' => 3
          }
        ]

        klines = Models::KlinesBuilder.new(raw_klines).execute(reverse: false)

        analyser = Robots::Analyser::Strategy2.new(klines)

        results = analyser.execute
        r1, r2, r3 = results

        expect(results.size).to eq 3
        expect(r1.action).to eq :buy
        expect(r1.kline.idx).to eq 6
        expect(r2.action).to eq :buy
        expect(r2.kline.idx).to eq 9
        expect(r3.action).to eq :sell
        expect(r3.kline.idx).to eq 10
      end
    end
  end

  # context 'klines' do
  #   before(:example) do
  #     data = [{ 'amount' => 619.3034099946908,
  #               'open' => 5363.03,
  #               'close' => 5324.98,
  #               'high' => 5372.27,
  #               'id' => 1_584_542_700,
  #               'count' => 3662,
  #               'low' => 5315.44,
  #               'vol' => 3_310_011.24424278 },
  #             { 'amount' => 1746.621948323623,
  #               'open' => 5330.88,
  #               'close' => 5363.02,
  #               'high' => 5375.0,
  #               'id' => 1_584_541_800,
  #               'count' => 10_310,
  #               'low' => 5318.5,
  #               'vol' => 9_337_528.878822388 },
  #             { 'amount' => 1601.6863071289633,
  #               'open' => 5365.12,
  #               'close' => 5330.88,
  #               'high' => 5379.0,
  #               'id' => 1_584_540_900,
  #               'count' => 8700,
  #               'low' => 5297.28,
  #               'vol' => 8_543_547.848085703 },
  #             { 'amount' => 3424.892319579545,
  #               'open' => 5338.64,
  #               'close' => 5366.0,
  #               'high' => 5385.0,
  #               'id' => 1_584_540_000,
  #               'count' => 18_016,
  #               'low' => 5300.01,
  #               'vol' => 18_322_816.65707355 },
  #             { 'amount' => 3998.7522974410435,
  #               'open' => 5214.95,
  #               'close' => 5337.34,
  #               'high' => 5380.0,
  #               'id' => 1_584_539_100,
  #               'count' => 21_453,
  #               'low' => 5192.98,
  #               'vol' => 21_205_114.4895674 },
  #             { 'amount' => 7339.38324966166,
  #               'open' => 5160.09,
  #               'close' => 5214.78,
  #               'high' => 5280.0,
  #               'id' => 1_584_538_200,
  #               'count' => 26_305,
  #               'low' => 5100.0,
  #               'vol' => 38_225_175.2884537 },
  #             { 'amount' => 3174.160273385421,
  #               'open' => 5075.43,
  #               'close' => 5160.09,
  #               'high' => 5200.0,
  #               'id' => 1_584_537_300,
  #               'count' => 14_970,
  #               'low' => 5010.0,
  #               'vol' => 16_120_765.467146443 },
  #             { 'amount' => 628.5184817831317,
  #               'open' => 5112.02,
  #               'close' => 5075.58,
  #               'high' => 5112.83,
  #               'id' => 1_584_536_400,
  #               'count' => 4520,
  #               'low' => 5071.0,
  #               'vol' => 3_198_780.836202033 },
  #             { 'amount' => 497.8182924480013,
  #               'open' => 5125.97,
  #               'close' => 5113.81,
  #               'high' => 5129.45,
  #               'id' => 1_584_535_500,
  #               'count' => 4206,
  #               'low' => 5096.32,
  #               'vol' => 2_545_253.8235769444 },
  #             { 'amount' => 668.8171413545598,
  #               'open' => 5101.15,
  #               'close' => 5127.22,
  #               'high' => 5140.22,
  #               'id' => 1_584_534_600,
  #               'count' => 5184,
  #               'low' => 5090.01,
  #               'vol' => 3_420_375.8741301564 }]

  #     @klines = Models::KlinesBuilder.new(data).execute(reverse: false)

  #   end

  #   it 'find trun_klines' do
  #     @analyser = Robots::Analyser::Kline.new(@klines)

  #     result = @analyser.execute

  #     expect(result.ready?).to eq true
  #     expect(result.turn_klines.map(&:close)).to eq [5127.22, 5113.81, 5160.09, 5330.88, 5363.02, 5324.98]
  #     expect(result.turn_down_klines.map(&:close)).to eq [5113.81, 5330.88, 5324.98]
  #     expect(result.turn_up_klines.map(&:close)).to eq [5127.22, 5160.09, 5363.02]
  #   end

  #   it 'down trend line' do
  #     @analyser = Robots::Analyser::Kline.new(@klines)
  #     result = @analyser.execute
  #     @analyser.show_open_prices

  #     trend_line = Robots::Analyser::TrendLine.new(result)

  #     puts '---go down---'
  #     down_stack = trend_line.go_down

  #     puts '---go up---'
  #     up_stack = trend_line.go_up

  #     puts '---down stack---'
  #     down_stack.each { |k| puts k.open }

  #     puts '---up stack---'
  #     up_stack.each { |k| puts k.open }

  #     expect(true).to eq true
  #   end
  # end
end
