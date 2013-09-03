require 'spec_helper'

describe ESPN::Client::Medals do
  before do
    @client = ESPN::Client.new
    stub_get 'medals.json'
  end

  it 'should get all medals' do
    @client.medals
    assert_requested :get, espn_url('sports/olympics/medals')
  end

end
