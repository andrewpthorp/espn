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

    context 'with a sports_name' do
      it 'gets all sports for that name' do
        stub_get('sports/baseball')
        @client.sports(sports_name: 'baseball')
        assert_requested :get, espn_url('sports/baseball')
      end
    end

    context 'with a sports_name and a league_name' do
      it 'gets all sports for that sport and league' do
        stub_get('sports/baseball/mlb')
        @client.sports(sports_name: 'baseball', league_name: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb')
      end
    end

    context 'with a league_name and no sports_name' do
      it 'gets all sports' do
        stub_get('sports')
        @client.sports(league_name: 'mlb')
        assert_requested :get, espn_url('sports')
      end
    end

  end
end
