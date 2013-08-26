require 'spec_helper'

describe ESPN::Request do
  before do
    @client = ESPN::Client.new
  end

  describe '#get' do
    it 'should call request' do
      opts = { foo: 'bar' }
      path = '/foo/bar'
      @client.should_receive(:request).with(:get, path, opts)
      @client.get(path, opts)
    end
  end

  describe '#build_url' do
    it 'should remove duplicate slashes' do
      @client.send(:build_url, '/foo///bar', {}).should eq('/foo/bar')
    end

    it 'should remove trailing slashes' do
      @client.send(:build_url, '/foo/bar/', {}).should eq('/foo/bar')
    end

    it 'should expand a pattern' do
      fragments = { foo: 'bar' }
      mock_uri = mock('URITemplate')
      URITemplate.stub(:new).and_return(mock_uri)
      mock_uri.should_receive(:expand).with(fragments).and_return('/')
      @client.send(:build_url, '/:some/pattern', fragments)
    end

    context 'when sport is not a fragment' do
      it 'should delete the league fragment' do
        fragments = { league: 'somerandomleague' }
        fragments.should_receive(:delete).with(:league)
        @client.send(:build_url, ':some/pattern', fragments)
      end
    end

    context 'when sport is a fragment' do
      it 'should not delete the league fragment' do
        fragments = { league: 'mlb', sport: 'baseball' }
        fragments.should_not_receive(:delete)
        @client.send(:build_url, ':some/pattern', fragments)
      end
    end
  end
end
