require 'spec_helper'

describe ESPN::Client::Headlines do
  before do
    @client = ESPN::Client.new
    stub_get 'headlines.json'
  end

  describe '#headline' do
    it 'should include the id in the request' do
      @client.headline(5)
      assert_requested :get, espn_url('sports/news/5')
    end

    it 'should not return an array' do
      @client.headline(5).should_not be_a(Array)
    end

    it 'should return the headline' do
      @client.headline(5).type.should eq('HeadlineNews')
    end
  end

  describe '#headlines' do
    it 'should return an array of headlines' do
      @client.headlines.first.type.should eq('HeadlineNews')
    end

    it 'should get headlines for sports by default' do
      @client.headlines
      assert_requested :get, espn_url('sports/news')
    end

    context 'when passing values as args' do
      context 'when passing the sport' do
        it 'should request headlines for that sport' do
          @client.headlines('horse-racing')
          assert_requested :get, espn_url('sports/horse-racing/news')
        end
      end

      context 'when passing the league' do
        it 'should request headlines for that league' do
          @client.headlines(:mlb)
          assert_requested :get, espn_url('sports/baseball/mlb/news')
        end
      end

      context 'when passing the league and sport' do
        it 'should request headlines for that sport and league' do
          @client.headlines('horse-racing', 'mlb')
          assert_requested :get, espn_url('sports/horse-racing/mlb/news')
        end
      end

      context 'when passing sport in the opts hash' do
        it 'should override the symbol with the opts' do
          @client.headlines(:basketball, sport: 'baseball')
          assert_requested :get, espn_url('sports/baseball/news')
        end
      end

      context 'when passing league in the opts hash' do
        it 'should override the symbol with the opts' do
          @client.headlines('wnba', league: 'mlb')
          assert_requested :get, espn_url('sports/basketball/mlb/news')
        end
      end
    end

    context 'when passing values in the opts hash' do
      context 'with a section param' do
        it 'should get headlines for that section' do
          @client.headlines(section: 'cities')
          assert_requested :get, espn_url('cities/news')
        end
      end

      context 'with a sport param' do
        it 'should get headlines for that sport' do
          @client.headlines(sport: 'baseball')
          assert_requested :get, espn_url('sports/baseball/news')
        end
      end

      context 'with a sport and league param' do
        it 'should get headlines for that sport and league' do
          @client.headlines(sport: 'baseball', league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/news')
        end
      end

      context 'with a league param but no sport param' do
        it 'should get headlines for that league mapped to a sport' do
          @client.headlines(league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/news')
        end
      end

      context 'with a method param' do
        it 'should get headlines for that method' do
          @client.headlines(method: 'top')
          assert_requested :get, espn_url('sports/news/headlines/top')
        end
      end
    end
  end

end
