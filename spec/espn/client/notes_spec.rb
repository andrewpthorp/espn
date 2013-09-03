require 'spec_helper'

describe ESPN::Client::Notes do
  before do
    @client = ESPN::Client.new
    stub_get 'notes.json'
  end

  describe '#notes' do
    it 'should return an array of notes' do
      @client.notes.first.respond_to?(:headline).should be_true
    end

    it 'gets all notes by default' do
      @client.notes
      assert_requested :get, espn_url('sports/news/notes')
    end

    context 'when passing values as args' do
      context 'when passing the sport' do
        it 'should request notes for that sport' do
          @client.notes(:football)
          assert_requested :get, espn_url('sports/football/news/notes')
        end
      end

      context 'when passing the league' do
        it 'should request notes for the league' do
          @client.notes(:nfl)
          assert_requested :get, espn_url('sports/football/nfl/news/notes')
        end
      end

      context 'when passing the league and sport' do
        it 'should request notes for that league and sport' do
          @client.notes(:baseball, 'mlb')
          assert_requested :get, espn_url('sports/baseball/mlb/news/notes')
        end
      end

      context 'when passing sport in the opts hash' do
        it 'should override the symbol with the opts' do
          @client.notes(:basketball, sport: 'baseball')
          assert_requested :get, espn_url('sports/baseball/news/notes')
        end
      end

      context 'when passing league in the opts hash' do
        it 'should override the symbol with the opts' do
          @client.notes('wnba', league: 'mlb')
          assert_requested :get, espn_url('sports/basketball/mlb/news/notes')
        end
      end
    end

    context 'with an id in the opts hash' do
      it 'should request that specific note' do
        @client.notes(id: 5)
        assert_requested :get, espn_url('sports/news/notes/5')
      end
    end
  end
end
