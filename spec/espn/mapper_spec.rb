require 'spec_helper'

describe ESPN::Mapper do
  before do
    @client = ESPN::Client.new
  end

  describe '#map_league_to_sport' do
    describe 'param types' do
      it 'should accept a string' do
        @client.map_league_to_sport('nhl').should include(sport: 'hockey')
      end

      it 'should accept a symbol' do
        @client.map_league_to_sport(:mlb).should include(sport: 'baseball')
      end
    end

    context 'with a league that has no mapping' do
      it 'should include nil for the sport' do
        @client.map_league_to_sport('foobar').should include(sport: nil)
      end
    end

    context 'with a given league (mma)' do
      ESPN::Mapper::LEAGUE_MAP[:mma].each do |league|
        it "should map #{league} to mma" do
          @client.map_league_to_sport(league).should include(sport: 'mma')
        end
      end
    end
  end

  describe '#sport?' do
    context 'with a valid sport' do
      it 'should return true with a symbol' do
        @client.sport?(:'horse-racing').should be_true
      end

      it 'should return true with a string' do
        @client.sport?(:baseball).should be_true
      end
    end

    context 'with an invalid sport' do
      it 'should return false' do
        @client.sport?(:mlb).should be_false
      end
    end
  end

  describe '#league?' do
    context 'with a valid league' do
      it 'should return true with a symbol' do
        @client.league?(:mlb).should be_true
      end

      it 'should return true with a string' do
        @client.league?('concacaf.champions_cup').should be_true
      end
    end

    context 'with an invalid league' do
      it 'should return false' do
        @client.league?(:baseball).should be_false
      end
    end
  end

  describe '#extract_league_and_sport' do
    context 'with a league' do
      it 'should return the sport, league' do
        @client.extract_league_and_sport([:mlb]).should eq(['baseball', 'mlb'])
      end
    end

    context 'with a sport' do
      it 'should return the sport and a blank string' do
        @client.extract_league_and_sport(['horse-racing']).should eq(['horse-racing', ''])
      end
    end

    context 'with a league and a sport' do
      it 'should return the first two args' do
        @client.extract_league_and_sport(['foo', 'bar']).should eq(['foo', 'bar'])
      end
    end

    context 'with more than two arguments' do
      it 'should return the first two args' do
        @client.extract_league_and_sport(['foo', 'bar', 'baz']).should eq(['foo', 'bar'])
      end
    end
  end

end
