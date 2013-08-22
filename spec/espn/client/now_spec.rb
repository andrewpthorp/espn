require 'spec_helper'

describe ESPN::Client::Now do
  before do
    @client = ESPN::Client.new
  end

  it 'gets all latest content' do
    stub_get('now')
    @client.now
    assert_requested :get, espn_url('now')
  end

  context 'with a method param' do
    it 'should include the method in the request' do
      stub_get('now/popular')
      @client.now(method: 'popular')
      assert_requested :get, espn_url('now/popular')
    end
  end

end
