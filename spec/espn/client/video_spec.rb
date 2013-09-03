require 'spec_helper'

describe ESPN::Client::Video do
  before do
    @client = ESPN::Client.new
    stub_get 'videos.json'
  end

  it 'should return an array of channels' do
    @client.videos.first.name.should eq('This is a video channel.')
  end

  it 'should get all clips' do
    @client.videos
    assert_requested :get, espn_url('video/channels/clips')
  end

  context 'with a category_id param' do
    it 'should include the category_id in the request' do
      @client.videos(category_id: 1)
      assert_requested :get, espn_url('video/channels/1/clips')
    end
  end

  context 'with a clip_id param' do
    it 'should include the clip_id in the request' do
      @client.videos(clip_id: 2)
      assert_requested :get, espn_url('video/channels/clips/2')
    end
  end

end
