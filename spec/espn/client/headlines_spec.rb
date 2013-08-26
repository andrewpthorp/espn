require 'spec_helper'

def stub_headlines(url)
  results = Hashie::Mash.new(headlines: [Hashie::Mash.new(headline: 'First Headline')])
  stub_get(url).to_return(body: results)
end

describe ESPN::Client::Headlines do
  before do
    @client = ESPN::Client.new
  end

  describe '#headline' do
    it 'should include the id in the request' do
      stub_headlines('sports/news/5')
      @client.headline(5)
      assert_requested :get, espn_url('sports/news/5')
    end

    it 'should not return an array' do
      stub_headlines('sports/news/5')
      @client.headline(5).should_not be_a(Array)
    end

    it 'should return the headline' do
      stub_headlines('sports/news/5')
      @client.headline(5).headline.should == 'First Headline'
    end
  end

  describe '#headlines' do
    it 'should return an array of headlines' do
      stub_headlines('sports/news')
      results = @client.headlines
      results.first.headline.should eq('First Headline')
    end

    it 'should get headlines for sports by default' do
      stub_headlines('sports/news')
      @client.headlines
      assert_requested :get, espn_url('sports/news')
    end

    context 'when passing values as args' do
      context 'when passing the sport' do
        it 'should request headlines for that sport' do
          stub_headlines('sports/horse-racing/news')
          @client.headlines('horse-racing')
          assert_requested :get, espn_url('sports/horse-racing/news')
        end
      end

      context 'when passing the league' do
        it 'should request headlines for that league' do
          stub_headlines('sports/baseball/mlb/news')
          @client.headlines(:mlb)
          assert_requested :get, espn_url('sports/baseball/mlb/news')
        end
      end

      context 'when passing the league and sport' do
        it 'should request headlines for that sport and league' do
          stub_headlines('sports/horse-racing/mlb/news')
          @client.headlines('horse-racing', 'mlb')
          assert_requested :get, espn_url('sports/horse-racing/mlb/news')
        end
      end

      context 'when passing sport in the opts hash' do
        it 'should override the symbol with the opts' do
          stub_headlines('sports/baseball/news')
          @client.headlines(:basketball, sport: 'baseball')
          assert_requested :get, espn_url('sports/baseball/news')
        end
      end

      context 'when passing league in the opts hash' do
        it 'should override the symbol with the opts' do
          stub_headlines('sports/basketball/mlb/news')
          @client.headlines('wnba', league: 'mlb')
          assert_requested :get, espn_url('sports/basketball/mlb/news')
        end
      end
    end

    context 'when passing values in the opts hash' do
      context 'with a section param' do
        it 'should get headlines for that section' do
          stub_headlines('cities/news')
          @client.headlines(section: 'cities')
          assert_requested :get, espn_url('cities/news')
        end
      end

      context 'with a sport param' do
        it 'should include the sport in the request' do
          stub_headlines('sports/baseball/news')
          @client.headlines(sport: 'baseball')
          assert_requested :get, espn_url('sports/baseball/news')
        end
      end

      context 'with a sport and league param' do
        it 'should include both params in the request' do
          stub_headlines('sports/baseball/mlb/news')
          @client.headlines(sport: 'baseball', league: 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/news')
        end
      end

      context 'with a league param but no sport param' do
        it 'should not include the league in the request' do
          stub_headlines('sports/news')
          @client.headlines(league: 'mlb')
          assert_requested :get, espn_url('sports/news')
        end
      end

      context 'with a method param' do
        it 'should include the method in the request' do
          stub_headlines('sports/news/headlines/top')
          @client.headlines(method: 'top')
          assert_requested :get, espn_url('sports/news/headlines/top')
        end
      end
    end
  end

end
