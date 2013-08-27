require 'spec_helper'

describe ESPN::Client::Video do
  before do
    @client = ESPN::Client.new
    stub_get 'videos.json'
  end

  it 'should get all clips' do
    @client.video
    assert_requested :get, espn_url('video/channels/clips')
  end

  context 'with a category_id param' do
    it 'should include the category_id in the request' do
      @client.video(category_id: 1)
      assert_requested :get, espn_url('video/channels/1/clips')
    end
  end

  context 'with a clip_id param' do
    it 'should include the clip_id in the request' do
      @client.video(clip_id: 2)
      assert_requested :get, espn_url('video/channels/clips/2')
    end
  end

end
