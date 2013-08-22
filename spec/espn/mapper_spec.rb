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
end
