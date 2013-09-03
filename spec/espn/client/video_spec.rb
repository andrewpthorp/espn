require 'spec_helper'

describe ESPN::Client::Video do
  before do
    @client = ESPN::Client.new
    stub_get 'videos.json'
  end

  it 'should return an array of channels' do
    results = @client.videos(1)
    results.first.name.should eq('This is a video channel.')
  end

  it 'should get all clips for a given channel' do
    @client.videos(1)
    assert_requested :get, espn_url('video/channels/1/clips')
  end

  context 'with a clip_id param' do
    it 'should include the clip_id in the request' do
      @client.videos(1, clip_id: 2)
      assert_requested :get, espn_url('video/channels/1/clips/2')
    end
  end

end
