require 'spec_helper'

describe ESPN::Client::Notes do
  before do
    @client = ESPN::Client.new
  end

  describe '#notes' do

    it 'gets all notes' do
      stub_get('sports/news/notes')
      @client.notes
      assert_requested :get, espn_url('sports/news/notes')
    end

    context 'with a sport param' do
      it 'should include the sport in the request' do
        stub_get('sports/baseball/news/notes')
        @client.notes(sport: 'baseball')
        assert_requested :get, espn_url('sports/baseball/news/notes')
      end

      context 'with a note_id param' do
        it 'should include the sport and note_id params in the request' do
          stub_get('sports/baseball/news/notes/5')
          @client.notes(sport: 'baseball', note_id: 5)
          assert_requested :get, espn_url('sports/baseball/news/notes/5')
        end
      end
    end

    context 'with a sport and a league param' do
      it 'should include the sport and league params in the request' do
        stub_get('sports/baseball/mlb/news/notes')
        @client.notes(sport: 'baseball', league: 'mlb')
        assert_requested :get, espn_url('sports/baseball/mlb/news/notes')
      end

      context 'with a note_id param' do
        it 'should include the sport, league and note_id params' do
          stub_get('sports/baseball/mlb/news/notes/1')
          @client.notes(sport: 'baseball', league: 'mlb', note_id: 1)
          assert_requested :get, espn_url('sports/baseball/mlb/news/notes/1')
        end
      end
    end

    context 'with a note_id param' do
      it 'should include the note_id in the request' do
        stub_get('sports/news/notes/5')
        @client.notes(note_id: 5)
        assert_requested :get, espn_url('sports/news/notes/5')
      end
    end

    context 'with a league param and no sport param' do
      it 'should not include either in the request' do
        stub_get('sports/news/notes')
        @client.notes(league: 'mlb')
        assert_requested :get, espn_url('sports/news/notes')
      end

      context 'with a note_id param' do
        it 'should include the note_id in the request' do
          stub_get('sports/news/notes/2')
          @client.notes(league: 'mlb', note_id: 2)
          assert_requested :get, espn_url('sports/news/notes/2')
        end
      end
    end

  end
end
