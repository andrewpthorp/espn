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

    context 'when passing values as args' do
      context 'when passing the sport' do
        it 'should request headlines for that sport' do
          stub_get('sports/horse-racing/news')
          @client.headlines('horse-racing')
          assert_requested :get, espn_url('sports/horse-racing/news')
        end
      end

      context 'when passing the league' do
        it 'should request headlines for that league' do
          stub_get('sports/baseball/mlb/news')
          @client.headlines(:mlb)
          assert_requested :get, espn_url('sports/baseball/mlb/news')
        end
      end

      context 'when passing the league and sport' do
        it 'should request headlines for that sport and league' do
          stub_get('sports/horse-racing/mlb/news')
          @client.headlines('horse-racing', 'mlb')
          assert_requested :get, espn_url('sports/horse-racing/mlb/news')
        end
      end

      context 'when passing sport in the opts hash' do
        it 'should override the symbol with the opts' do
          stub_get('sports/baseball/news')
          @client.headlines(:basketball, sport: 'baseball')
          assert_requested :get, espn_url('sports/baseball/news')
        end
      end

      context 'when passing league in the opts hash' do
        it 'should override the symbol with the opts' do
          stub_get('sports/basketball/mlb/news')
          @client.headlines('wnba', league: 'mlb')
          assert_requested :get, espn_url('sports/basketball/mlb/news')
        end
      end
    end

    context 'when passing values in the opts hash' do
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

      context 'with a id param' do
        it 'should include the id in the request' do
          stub_get('sports/news/5')
          @client.headlines(id: 5)
          assert_requested :get, espn_url('sports/news/5')
        end
      end
    end

  end
end
