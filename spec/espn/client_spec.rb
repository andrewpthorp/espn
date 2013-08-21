require 'spec_helper'

describe ESPN::Client do
  before do
    @client = ESPN::Client.new
  end

  describe '.attr_accessors' do
    ESPN::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should respond_to :#{key}" do
        @client.respond_to?(key).should be_true
      end

      it "should respond_to :#{key}=" do
        @client.respond_to?("#{key}=").should be_true
      end
    end
  end

  describe '.initialize' do
    it 'should pass valid keys to the client' do
      client = ESPN::Client.new(api_key: 'abc123')
      client.api_key.should == 'abc123'
    end
  end

  describe '#api_url' do
    it 'should return the correct url' do
      @client.api_url.should eq('http://api.espn.com/v1/')
    end
  end

  describe '#authed?' do
    context 'when api_key is nil' do
      it 'should be false' do
        @client.api_key = nil
        @client.should_not be_authed
      end
    end

    context 'when api_key is not nil' do
      it 'should be true' do
        @client.api_key = 'abc123'
        @client.should be_authed
      end
    end
  end

end
