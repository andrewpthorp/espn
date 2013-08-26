require 'spec_helper'

describe Faraday::Response::RaiseESPNError do
  before do
    @class = described_class.new
  end

  context 'when used' do
    before do
      @response = Hashie::Mash.new(method: :get, url: 'http://test')
      @response.body = Hashie::Mash.new(status: 'error', message: 'foobar')
    end

    it 'does not raise an error if the response has no body' do
      @response.body = nil
      lambda {
        @class.on_complete(@response)
      }.should_not raise_error
    end

    it 'does not raise an error for HTTP 200' do
      @response.body.code = 200
      lambda {
        @class.on_complete(@response)
      }.should_not raise_error
    end

    it 'raises an error for HTTP 400' do
      @response.body.code = 400
      lambda {
        @class.on_complete(@response)
      }.should raise_error(ESPN::BadRequest)
    end

    it 'raises an error for HTTP 401' do
      @response.body.code = 401
      lambda {
        @class.on_complete(@response)
      }.should raise_error(ESPN::Unauthorized)
    end

    it 'raises an error for HTTP 403' do
      @response.body.code = 403
      lambda {
        @class.on_complete(@response)
      }.should raise_error(ESPN::Forbidden)
    end

    it 'raises an error for HTTP 404' do
      @response.body.code = 404
      lambda {
        @class.on_complete(@response)
      }.should raise_error(ESPN::NotFound)
    end

    it 'raises an error for HTTP 500' do
      @response.body.code = 500
      lambda {
        @class.on_complete(@response)
      }.should raise_error(ESPN::InternalServerError)
    end

    it 'raises an error fro HTTP 504' do
      @response.body.code = 504
      lambda {
        @class.on_complete(@response)
      }.should raise_error(ESPN::GatewayTimeout)
    end
  end

  describe '#error_message' do
    it 'should be formatted correctly' do
      response = Hashie::Mash.new(method: :get, url: 'http://test')
      response.body = Hashie::Mash.new(status: 'error', message: 'some error')
      result = @class.error_message(response)
      result.should eq('GET http://test: error - some error')
    end
  end

end
