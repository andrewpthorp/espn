require 'spec_helper'

describe ESPN::Client::Sports do
  before do
    @client = ESPN::Client.new
  end

  describe '#sports' do

    it 'gets all sports' do
      stub_get('sports')
      @client.sports
      assert_requested :get, espn_url('sports')
    end

    context 'with a sport param' do
      it 'should include the sport param in the request' do
        stub_get('sports/baseball')
        @client.sports(sport: 'baseball')
        assert_requested :get, espn_url('sports/baseball')
      end
    end

    context 'with a sport and a league param' do
      it 'should include both params in the request' do
        stub_get('sports/baseball/mlb')
        @client.sports(sport: 'baseball', league: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb')
      end
    end

    context 'with a league param but no sport param' do
      it 'should not include the league param in the request' do
        stub_get('sports')
        @client.sports(league: 'mlb')
        assert_requested :get, espn_url('sports')
      end
    end

  end
end
