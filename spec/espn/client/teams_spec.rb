require 'spec_helper'

describe ESPN::Client::Sports do
  before do
    @client = ESPN::Client.new
  end

  describe '#teams' do

    it 'gets all teams' do
      stub_get('sports/teams')
      @client.teams
      assert_requested :get, espn_url('sports/teams')
    end

    context 'with a sport' do
      it 'gets all teams for that name' do
        stub_get('sports/baseball/teams')
        @client.teams(sport: 'baseball')
        assert_requested :get, espn_url('sports/baseball/teams')
      end

      context 'with a team_id' do
        it 'gets all teams for that sport and team_id' do
          stub_get('sports/baseball/teams/5')
          @client.teams(sport: 'baseball', team_id: 5)
          assert_requested :get, espn_url('sports/baseball/teams/5')
        end
      end
    end

    context 'with a sport and a league' do
      it 'gets all teams for that sport and league' do
        stub_get('sports/baseball/mlb/teams')
        @client.teams(sport: 'baseball', league: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb/teams')
      end

      context 'with a team_id' do
        it 'gets all teams for that sport and league with the team_id' do
          stub_get('sports/baseball/mlb/teams/1')
          @client.teams(sport: 'baseball', league: 'mlb', team_id: 1)
          assert_requested :get, espn_url('sports/baseball/mlb/teams/1')
        end
      end
    end

    context 'with a team_id' do
      it 'gets all teams for that team_id' do
        stub_get('sports/teams/5')
        @client.teams(team_id: 5)
        assert_requested :get, espn_url('sports/teams/5')
      end
    end

    context 'with a league and no sport' do
      it 'gets all teams' do
        stub_get('sports/teams')
        @client.teams(league: 'mlb')
        assert_requested :get, espn_url('sports/teams')
      end

      context 'with a team_id' do
        it 'gets all teams for taht team_id' do
          stub_get('sports/teams/2')
          @client.teams(league: 'mlb', team_id: 2)
          assert_requested :get, espn_url('sports/teams/2')
        end
      end
    end

  end
end
