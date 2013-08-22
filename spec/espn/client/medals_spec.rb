require 'spec_helper'

describe ESPN::Client::Medals do
  before do
    @client = ESPN::Client.new
  end

  it 'should get all medals' do
    stub_get('sports/olympics/medals')
    @client.medals
    assert_requested :get, espn_url('sports/olympics/medals')
  end

end
