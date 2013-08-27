require 'spec_helper'

describe ESPN::Client::Sports do
  before do
    @client = ESPN::Client.new
    stub_get 'sports.json'
  end

  describe '#sports' do
    it 'returns an array of sports' do
      @client.sports.first.name.should eq('baseball')
    end

    it 'gets all sports' do
      @client.sports
      assert_requested :get, espn_url('sports')
    end

    context 'when passing values as args' do
      context 'when passing the sport' do
        it 'should request that sport' do
          @client.sports(:baseball)
          assert_requested :get, espn_url('sports/baseball')
        end
      end

      context 'when passing the league' do
        it 'should request that league' do
          @client.sports(:mlb)
          assert_requested :get, espn_url('sports/baseball/mlb')
        end
      end

      context 'when passing the sport and league' do
        it 'should request that sport and league' do
          @client.sports(:baseball, :nba)
          assert_requested :get, espn_url('sports/baseball/nba')
        end
      end

      context 'when passing the league in the opts hash' do
        it 'should override the arg' do
          @client.sports(:nba, league: 'mlb')
          assert_requested :get, espn_url('sports/basketball/mlb')
        end
      end

      context 'when passing the sport in the opts hash' do
        it 'should override the arg' do
          @client.sports(:baseball, sport: :basketball)
          assert_requested :get, espn_url('sports/basketball')
        end
      end
    end

    context 'when passing values in the opts hash' do
      context 'with a sport param' do
        it 'should include the sport param in the request' do
          @client.sports(sport: 'baseball')
          assert_requested :get, espn_url('sports/baseball')
        end
      end

      context 'with a sport and a league param' do
        it 'should include both params in the request' do
          @client.sports(sport: 'baseball', league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb')
        end
      end

      context 'with a league param but no sport param' do
        it 'should map the league to a sport' do
          @client.sports(league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb')
        end
      end
    end
  end
end
