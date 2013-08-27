require 'spec_helper'

describe ESPN::Client::Standings do
  before do
    @client = ESPN::Client.new
    stub_get 'standings.json'
  end

  describe '#standings' do

    it 'gets all standings' do
      @client.standings
      assert_requested :get, espn_url('sports/standings')
    end

    context 'with a sport param' do
      it 'should include the sport in the request' do
        @client.standings(sport: 'baseball')
        assert_requested :get, espn_url('sports/baseball/standings')
      end
    end

    context 'with a sport and a league param' do
      it 'should include the sport and league params in the request' do
        @client.standings(sport: 'baseball', league: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb/standings')
      end
    end

    context 'with a league param and no sport param' do
      it 'should not include either in the request' do
        @client.standings(league: 'mlb')
        assert_requested :get, espn_url('sports/standings')
      end
    end

  end
end
