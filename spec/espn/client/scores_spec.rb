require 'spec_helper'

describe ESPN::Client::Scores do
  before do
    @client = ESPN::Client.new
    stub_get 'scores.json'
  end

  describe '#score' do
    it 'should return an event' do
      @client.score(1).competitions.is_a?(Array).should be_true
    end

    it 'should request the specific event' do
      @client.score(1)
      assert_requested :get, espn_url('sports/events/1')
    end
  end

  describe '#scores' do
    it 'returns an array of events with scores' do
      @client.scores.first.respond_to?(:competitions).should be_true
    end

    it 'gets all scores' do
      @client.scores
      assert_requested :get, espn_url('sports/events')
    end

    context 'when passing values as args' do
      context 'when passing the sport' do
        it 'should request scores for that sport' do
          @client.scores(:baseball)
          assert_requested :get, espn_url('sports/baseball/events')
        end
      end

      context 'when passing the league' do
        it 'should request scores for that league' do
          @client.scores(:nba)
          assert_requested :get, espn_url('sports/basketball/nba/events')
        end
      end

      context 'when passing the sport and league' do
        it 'should request scores for that league and sport' do
          @client.scores(:baseball, :nba)
          assert_requested :get, espn_url('sports/baseball/nba/events')
        end
      end

      context 'when passing the league in the opts hash' do
        it 'should override the arg' do
          @client.scores(:nba, league: 'mlb')
          assert_requested :get, espn_url('sports/basketball/mlb/events')
        end
      end

      context 'when passing the sport in the opts hash' do
        it 'should override the arg' do
          @client.scores(:baseball, sport: 'basketball')
          assert_requested :get, espn_url('sports/basketball/events')
        end
      end
    end

    context 'when passing values in the opts hash' do
      context 'with a sport param' do
        it 'should include the sport in the request' do
          @client.scores(sport: 'baseball')
          assert_requested :get, espn_url('sports/baseball/events')
        end
      end

      context 'with a sport and a league param' do
        it 'should include the sport and league params in the request' do
          @client.scores(sport: 'baseball', league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/events')
        end
      end

      context 'with a league param and no sport param' do
        it 'should map the league to a sport' do
          @client.scores(league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/events')
        end
      end
    end
  end
end
