require 'spec_helper'

def stub_athletes(url)
  athlete = Hashie::Mash.new(fullName: 'Chase Utley')
  results = default_response(:athletes, athlete)
  stub_get(url).to_return(body: results)
end

describe ESPN::Client::Athletes do
  before do
    @client = ESPN::Client.new
  end

  describe '#athletes' do

    context 'when league is not passed' do
      it 'should raise an argument error' do
        expect { @client.athletes }.to raise_error(ArgumentError)
      end
    end

    context 'when invalid league is passed' do
      it 'should raise an argument error' do
        expect { @client.athletes(:foobar) }.to raise_error(ArgumentError)
      end
    end

    it 'should return an array of athletes' do
      stub_athletes('sports/baseball/mlb/athletes')
      results = @client.athletes(:mlb)
      results.first.fullName.should eq('Chase Utley')
    end

    it 'should accept a league in the opts hash' do
      stub_athletes('sports/baseball/mlb/athletes')
      results = @client.athletes(league: 'mlb')
      assert_requested :get, espn_url('sports/baseball/mlb/athletes')
    end

    context 'when passing an id in the opts hash' do
      it 'should request only that athlete' do
        stub_athletes('sports/baseball/mlb/athletes/1')
        results = @client.athletes(:mlb, id: 1)
        assert_requested :get, espn_url('sports/baseball/mlb/athletes/1')
      end
    end

  end
end
