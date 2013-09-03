require 'spec_helper'

describe ESPN::Client::Audio do
  before do
    @client = ESPN::Client.new
    stub_get 'audio.json'
  end

  describe '#audio' do
    it 'should return an array of podcast recordings' do
      @client.audio.first.categories.first.respond_to?(:podcast).should be_true
    end

    it 'should get all podcasts by default' do
      @client.audio
      assert_requested :get, espn_url('audio/podcasts')
    end

    context 'with a method param' do
      it 'should include the method in the request' do
        @client.audio(method: 'recordings')
        assert_requested :get, espn_url('audio/recordings')
      end

      context 'if method is podcast_recordings' do
        it 'should convert to podcasts/recordings' do
          @client.audio(method: 'podcast_recordings')
          assert_requested :get, espn_url('audio/podcasts/recordings')
        end
      end
    end

    context 'with a podcast_id param' do
      it 'should include the podcast_id in the param' do
        @client.audio(podcast_id: 1)
        assert_requested :get, espn_url('audio/podcasts/1')
      end
    end

    context 'with a recording_id param' do
      it 'should include the recording_id in the param' do
        @client.audio(recording_id: 2)
        assert_requested :get, espn_url('audio/podcasts/2')
      end
    end
  end
end
