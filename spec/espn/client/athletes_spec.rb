require 'spec_helper'

describe ESPN::Client::Athletes do
  before do
    @client = ESPN::Client.new
  end

  describe '#athletes' do

    it 'gets all athletes' do
      stub_get('sports/athletes')
      @client.athletes
      assert_requested :get, espn_url('sports/athletes')
    end

    context 'with a sport param' do
      it 'should include the sport in the request' do
        stub_get('sports/baseball/athletes')
        @client.athletes(sport: 'baseball')
        assert_requested :get, espn_url('sports/baseball/athletes')
      end

      context 'with a athlete_id param' do
        it 'should include the sport and athlete_id params in the request' do
          stub_get('sports/baseball/athletes/5')
          @client.athletes(sport: 'baseball', athlete_id: 5)
          assert_requested :get, espn_url('sports/baseball/athletes/5')
        end
      end
    end

    context 'with a sport and a league param' do
      it 'should include the sport and league params in the request' do
        stub_get('sports/baseball/mlb/athletes')
        @client.athletes(sport: 'baseball', league: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb/athletes')
      end

      context 'with a athlete_id param' do
        it 'should include the sport, league and athlete_id params' do
          stub_get('sports/baseball/mlb/athletes/1')
          @client.athletes(sport: 'baseball', league: 'mlb', athlete_id: 1)
          assert_requested :get, espn_url('sports/baseball/mlb/athletes/1')
        end
      end
    end

    context 'with a athlete_id param' do
      it 'should include the athlete_id in the request' do
        stub_get('sports/athletes/5')
        @client.athletes(athlete_id: 5)
        assert_requested :get, espn_url('sports/athletes/5')
      end
    end

    context 'with a league param and no sport param' do
      it 'should not include either in the request' do
        stub_get('sports/athletes')
        @client.athletes(league: 'mlb')
        assert_requested :get, espn_url('sports/athletes')
      end

      context 'with a athlete_id param' do
        it 'should include the athlete_id in the request' do
          stub_get('sports/athletes/2')
          @client.athletes(league: 'mlb', athlete_id: 2)
          assert_requested :get, espn_url('sports/athletes/2')
        end
      end
    end

  end
end
