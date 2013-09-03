require 'spec_helper'

describe ESPN::Client::Now do
  before do
    @client = ESPN::Client.new
    stub_get 'now.json'
  end

  it 'gets all latest content' do
    @client.now
    assert_requested :get, espn_url('now')
  end

  context 'with a method param' do
    it 'should include the method in the request' do
      @client.now(method: 'popular')
      assert_requested :get, espn_url('now/popular')
    end
  end

end
