require 'spec_helper'

describe ESPN::Client::Scores do
  before do
    @client = ESPN::Client.new
    stub_get 'scores.json'
  end

  describe '#scores' do

    it 'gets all scores' do
      @client.scores
      assert_requested :get, espn_url('sports/events')
    end

    context 'with a sport param' do
      it 'should include the sport in the request' do
        @client.scores(sport: 'baseball')
        assert_requested :get, espn_url('sports/baseball/events')
      end

      context 'with a event_id param' do
        it 'should include the sport and event_id params in the request' do
          @client.scores(sport: 'baseball', event_id: 5)
          assert_requested :get, espn_url('sports/baseball/events/5')
        end
      end
    end

    context 'with a sport and a league param' do
      it 'should include the sport and league params in the request' do
        @client.scores(sport: 'baseball', league: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb/events')
      end

      context 'with a event_id param' do
        it 'should include the sport, league and event_id params' do
          @client.scores(sport: 'baseball', league: 'mlb', event_id: 1)
          assert_requested :get, espn_url('sports/baseball/mlb/events/1')
        end
      end
    end

    context 'with a event_id param' do
      it 'should include the event_id in the request' do
        @client.scores(event_id: 5)
        assert_requested :get, espn_url('sports/events/5')
      end
    end

    context 'with a league param and no sport param' do
      it 'should not include either in the request' do
        @client.scores(league: 'mlb')
        assert_requested :get, espn_url('sports/events')
      end

      context 'with a event_id param' do
        it 'should include the event_id in the request' do
          @client.scores(league: 'mlb', event_id: 2)
          assert_requested :get, espn_url('sports/events/2')
        end
      end
    end

  end
end
