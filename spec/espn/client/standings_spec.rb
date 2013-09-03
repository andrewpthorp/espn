require 'spec_helper'

describe ESPN::Client::Standings do
  before do
    @client = ESPN::Client.new
    stub_get 'standings.json'
  end

  describe '#standings' do
    it 'returns an array of standings' do
      team = @client.standings(:mlb).first.groups.first
      team.competitors.is_a?(Array).should be_true
    end

    it 'gets all standings for a given league' do
      @client.standings(:mlb)
      assert_requested :get, espn_url('sports/baseball/mlb/standings')
    end

    context 'when league is not passed' do
      it 'should raise an argument error' do
        expect { @client.standings }.to raise_error(ArgumentError)
      end
    end

    context 'when invalid league is passed' do
      it 'should raise an argument error' do
        expect { @client.standings(:foobar) }.to raise_error(ArgumentError)
      end
    end

    context 'when passing values as args' do
      context 'when passing the league' do
        it 'should map that league to a sport' do
          @client.standings(:mlb)
          assert_requested :get, espn_url('sports/baseball/mlb/standings')
        end
      end

      context 'when passing the sport and league' do
        it 'should get standings for that sport and league' do
          @client.standings(:football, :nfl)
          assert_requested :get, espn_url('sports/football/nfl/standings')
        end
      end
    end

    context 'when passing values in the opts hash' do
      context 'with a league param' do
        it 'should map the league to a sport' do
          @client.standings(league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/standings')
        end
      end

      context 'with a sport and a league param' do
        it 'should include the sport and league params in the request' do
          @client.standings(sport: 'baseball', league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/standings')
        end
      end
    end
  end
end
