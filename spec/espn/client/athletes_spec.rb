require 'spec_helper'

describe ESPN::Client::Athletes do
  before do
    @client = ESPN::Client.new
    stub_get 'athletes.json'
  end

  describe '#athlete' do
    it 'should return an athlete' do
      @client.athlete(1, :mlb).fullName.should eq('Chase Utley')
    end

    it 'should get an athlete for the given league' do
      @client.athlete(1, :mlb)
      assert_requested :get, espn_url('sports/baseball/mlb/athletes/1')
    end

    it 'should accept a league in the opts hash' do
      @client.athlete(1, league: 'mlb')
      assert_requested :get, espn_url('sports/baseball/mlb/athletes/1')
    end

    context 'when league is not passed' do
      it 'should raise an argument error' do
        expect { @client.athlete(1) }.to raise_error(ArgumentError)
      end
    end

    context 'when invalid league is passed' do
      it 'should raise an argument error' do
        expect { @client.athlete(1, :foobar) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#athletes' do
    it 'should return an array of athletes' do
      @client.athletes(:mlb).first.fullName.should eq('Chase Utley')
    end

    it 'should get athletes for the given league' do
      @client.athletes(:nba)
      assert_requested :get, espn_url('sports/basketball/nba/athletes')
    end

    it 'should accept a league in the opts hash' do
      @client.athletes(league: 'mlb')
      assert_requested :get, espn_url('sports/baseball/mlb/athletes')
    end

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
  end
end
