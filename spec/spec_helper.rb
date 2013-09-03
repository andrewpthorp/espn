require 'espn'
require 'json'
require 'rspec'
require 'webmock/rspec'
require 'hashie'

def stub_get(file=nil)
  if file.nil?
    stub_request(:get, /api.espn.com/)
  else
    response = {
      body: Hashie::Mash.new(JSON.parse(IO.read("spec/responses/#{file}")))
    }
    stub_request(:get, /api.espn.com/).to_return(response)
  end
end

def espn_url(url)
  "http://api.espn.com/v1/#{url}"
end
