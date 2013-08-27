require 'espn'
require 'rspec'
require 'webmock/rspec'
require 'hashie'

def stub_get(url)
  stub_request(:get, espn_url(url))
end

def espn_url(url)
  "http://api.espn.com/v1/#{url}"
end

def default_response(key, node)
  results = Hashie::Mash.new
  results.sports = [Hashie::Mash.new]
  results.sports.first.leagues = [Hashie::Mash.new]
  results.sports.first.leagues.first[key] = [node]
  return results
end
