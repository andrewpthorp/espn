require 'spec_helper'

describe ESPN::Client::Teams do
  before do
    @client = ESPN::Client.new
    stub_get 'teams.json'
  end

  describe '#teams' do
    it 'returns an array of teams' do
      @client.teams(:mlb).first.name.should eq('Phillies')
    end

    it 'gets all teams for a given league' do
      @client.teams(:nba)
      assert_requested :get, espn_url('sports/basketball/nba/teams')
    end

    context 'when league is not passed' do
      it 'should raise an argument error' do
        expect { @client.teams }.to raise_error(ArgumentError)
      end
    end

    context 'when invalid league is passed' do
      it 'should raise an argument error' do
        expect { @client.teams(:foobar) }.to raise_error(ArgumentError)
      end
    end

    context 'when passing values as args' do
      context 'when passing a league' do
        it 'should map that league to a sport' do
          @client.teams(:mlb)
          assert_requested :get, espn_url('sports/baseball/mlb/teams')
        end
      end

      context 'when passing a sport and a league' do
        it 'should get teams for that sport and league' do
          @client.teams(:football, :nfl)
          assert_requested :get, espn_url('sports/football/nfl/teams')
        end
      end
    end

    context 'when passing values in the opts hash' do
      context 'when passing an id' do
        it 'should get that specific team' do
          @client.teams(:mlb, id: 5)
          assert_requested :get, espn_url('sports/baseball/mlb/teams/5')
        end
      end

      context 'when passing a league' do
        it 'should map that league to a sport' do
          @client.teams(league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/teams')
        end
      end

      context 'when passing a sport and a league' do
        it 'should get teams for that sport and league' do
          @client.teams(sport: 'football', league: 'nfl')
          assert_requested :get, espn_url('sports/football/nfl/teams')
        end
      end
    end
  end
end
