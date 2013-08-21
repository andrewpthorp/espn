require 'espn'
require 'rspec'
require 'webmock/rspec'

def stub_get(url)
  stub_request(:get, espn_url(url))
end

def espn_url(url)
  "http://api.espn.com/v1/#{url}"
end
