require 'spec_helper'

class MockMapper
  include ESPN::Mapper
end

describe ESPN::Mapper do
  before do
    @mapper = MockMapper.new
  end

  describe '#map_league_to_sport' do
    describe 'param types' do
      it 'should accept a string' do
        @mapper.map_league_to_sport('nhl').should include(sport: 'hockey')
      end

      it 'should accept a symbol' do
        @mapper.map_league_to_sport(:mlb).should include(sport: 'baseball')
      end
    end

    context 'with a league that has no mapping' do
      it 'should include nil for the sport' do
        @mapper.map_league_to_sport('foobar').should include(sport: nil)
      end
    end

    context 'with a given league (mma)' do
      ESPN::Mapper::LEAGUE_MAP[:mma].each do |league|
        it "should map #{league} to mma" do
          @mapper.map_league_to_sport(league).should include(sport: 'mma')
        end
      end
    end
  end

  describe '#sport?' do
    context 'with a valid sport' do
      it 'should return true with a symbol' do
        @mapper.sport?(:'horse-racing').should be_true
      end

      it 'should return true with a string' do
        @mapper.sport?(:baseball).should be_true
      end
    end

    context 'with an invalid sport' do
      it 'should return false' do
        @mapper.sport?(:mlb).should be_false
      end
    end
  end

  describe '#league?' do
    context 'with a valid league' do
      it 'should return true with a symbol' do
        @mapper.league?(:mlb).should be_true
      end

      it 'should return true with a string' do
        @mapper.league?('concacaf.champions_cup').should be_true
      end
    end

    context 'with an invalid league' do
      it 'should return false' do
        @mapper.league?(:baseball).should be_false
      end
    end
  end

  describe '#extract_sport_and_league' do
    context 'with a league' do
      it 'should return the sport, league' do
        @mapper.extract_sport_and_league(['mlb']).should eq(['baseball', 'mlb'])
      end

      it 'should convert symbols to strings' do
        @mapper.extract_sport_and_league([:mlb]).should eq(['baseball', 'mlb'])
      end
    end

    context 'with a sport' do
      it 'should return the sport and a blank string' do
        results = @mapper.extract_sport_and_league(['horse-racing'])
        results.should eq(['horse-racing', ''])
      end

      it 'should convert symbols to strings' do
        results = @mapper.extract_sport_and_league([:baseball])
        results.should eq(['baseball', ''])
      end
    end

    context 'with a league and a sport' do
      it 'should return the first two args' do
        results = @mapper.extract_sport_and_league(['foo', 'bar'])
        results.should eq(['foo', 'bar'])
      end

      it 'should convert symbols to strings' do
        results = @mapper.extract_sport_and_league([:foo, :bar])
        results.should eq(['foo', 'bar'])
      end
    end

    context 'with more than two arguments' do
      it 'should return the first two args' do
        results = @mapper.extract_sport_and_league(['foo', 'bar', 'baz'])
        results.should eq(['foo', 'bar'])
      end
    end

    context 'with sport in the opts hash' do
      it 'should return the sport from the opts hash' do
        results = @mapper.extract_sport_and_league(['foo'], sport: 'bar')
        results.should eq(['bar', ''])
      end
    end

    context 'with league in the opts hash' do
      it 'should return the league from the opts hash' do
        results = @mapper.extract_sport_and_league(['mlb'], league: 'foo')
        results.should eq(['baseball', 'foo'])
      end

      it 'should map the league to a sport' do
        results = @mapper.extract_sport_and_league([], league: 'mlb')
        results.should eq(['baseball', 'mlb'])
      end
    end
  end

end
