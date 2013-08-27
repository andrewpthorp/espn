require 'spec_helper'

describe ESPN::Client::Athletes do
  before do
    @client = ESPN::Client.new
    stub_get 'athletes.json'
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
      results = @client.athletes(:mlb)
      results.first.fullName.should eq('Chase Utley')
    end

    it 'should accept a league in the opts hash' do
      results = @client.athletes(league: 'mlb')
      assert_requested :get, espn_url('sports/baseball/mlb/athletes')
    end

    context 'when passing an id in the opts hash' do
      it 'should request only that athlete' do
        results = @client.athletes(:mlb, id: 1)
        assert_requested :get, espn_url('sports/baseball/mlb/athletes/1')
      end
    end

  end
end
