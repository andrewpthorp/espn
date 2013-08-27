require 'spec_helper'

describe ESPN::Client::Teams do
  before do
    @client = ESPN::Client.new
    stub_get 'teams.json'
  end

  describe '#teams' do

    it 'gets all teams' do
      @client.teams
      assert_requested :get, espn_url('sports/teams')
    end

    context 'with a sport param' do
      it 'should include the sport in the request' do
        @client.teams(sport: 'baseball')
        assert_requested :get, espn_url('sports/baseball/teams')
      end

      context 'with a team_id param' do
        it 'should include the sport and team_id params in the request' do
          @client.teams(sport: 'baseball', team_id: 5)
          assert_requested :get, espn_url('sports/baseball/teams/5')
        end
      end
    end

    context 'with a sport and a league param' do
      it 'should include the sport and league params in the request' do
        @client.teams(sport: 'baseball', league: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb/teams')
      end

      context 'with a team_id param' do
        it 'should include the sport, league and team_id params' do
          @client.teams(sport: 'baseball', league: 'mlb', team_id: 1)
          assert_requested :get, espn_url('sports/baseball/mlb/teams/1')
        end
      end
    end

    context 'with a team_id param' do
      it 'should include the team_id in the request' do
        @client.teams(team_id: 5)
        assert_requested :get, espn_url('sports/teams/5')
      end
    end

    context 'with a league param and no sport param' do
      it 'should not include either in the request' do
        @client.teams(league: 'mlb')
        assert_requested :get, espn_url('sports/teams')
      end

      context 'with a team_id param' do
        it 'should include the team_id in the request' do
          @client.teams(league: 'mlb', team_id: 2)
          assert_requested :get, espn_url('sports/teams/2')
        end
      end
    end

  end
end
