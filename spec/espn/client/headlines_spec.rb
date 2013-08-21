require 'spec_helper'

describe ESPN::Client::Headlines do
  before do
    @client = ESPN::Client.new
  end

  describe '#headlines' do
    it 'should get headlines for sports by default' do
      stub_get('sports/news')
      @client.headlines
      assert_requested :get, espn_url('sports/news')
    end

    context 'with a section param' do
      it 'should get headlines for that section' do
        stub_get('cities/news')
        @client.headlines(section: 'cities')
        assert_requested :get, espn_url('cities/news')
      end
    end

    context 'with a sport param' do
      it 'should include the sport in the request' do
        stub_get('sports/baseball/news')
        @client.headlines(sport: 'baseball')
        assert_requested :get, espn_url('sports/baseball/news')
      end
    end

    context 'with a sport and league param' do
      it 'should include both params in the request' do
        stub_get('sports/baseball/mlb/news')
        @client.headlines(sport: 'baseball', league: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb/news')
      end
    end

    context 'with a league param but no sport param' do
      it 'should not include the league in the request' do
        stub_get('sports/news')
        @client.headlines(league: 'mlb')
        assert_requested :get, espn_url('sports/news')
      end
    end

    context 'with a method param' do
      it 'should include the method in the request' do
        stub_get('sports/news/headlines/top')
        @client.headlines(method: 'top')
        assert_requested :get, espn_url('sports/news/headlines/top')
      end
    end

    context 'with a headline_id param' do
      it 'should include the headline_id in the request' do
        stub_get('sports/news/5')
        @client.headlines(headline_id: 5)
        assert_requested :get, espn_url('sports/news/5')
      end
    end
  end

end
