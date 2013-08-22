require 'spec_helper'

describe ESPN::Client::Audio do
  before do
    @client = ESPN::Client.new
  end

  it 'should get all podcasts' do
    stub_get('audio/podcasts')
    @client.audio
    assert_requested :get, espn_url('audio/podcasts')
  end

  context 'with a method param' do
    context 'if method is podcast_recordings' do
      it 'should include podcasts/recordings in the request' do
        stub_get('audio/podcasts/recordings')
        @client.audio(method: 'podcast_recordings')
        assert_requested :get, espn_url('audio/podcasts/recordings')
      end
    end

    it 'should include the method in the request' do
      stub_get('audio/recordings')
      @client.audio(method: 'recordings')
      assert_requested :get, espn_url('audio/recordings')
    end
  end

  context 'with a podcast_id param' do
    it 'should include the podcast_id in the param' do
      stub_get('audio/podcasts/1')
      @client.audio(podcast_id: 1)
      assert_requested :get, espn_url('audio/podcasts/1')
    end
  end

  context 'with a recording_id param' do
    it 'should include the recording_id in the param' do
      stub_get('audio/podcasts/2')
      @client.audio(recording_id: 2)
      assert_requested :get, espn_url('audio/podcasts/2')
    end
  end

end
