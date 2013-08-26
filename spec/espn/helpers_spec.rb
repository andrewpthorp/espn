require 'spec_helper'

describe ESPN::Request do
  before do
    @client = ESPN::Client.new
  end

  describe '#extract_options!' do
    context 'when the last param is a hash' do
      before do
        @opts = { foo: 'bar' }
        @args = [1, 'b', @opts]
      end

      it 'should return that hash' do
        @client.extract_options!(@args).should eq(@opts)
      end

      it 'should remove that has from the array' do
        size = @args.size
        @client.extract_options!(@args)
        @args.size.should == size-1
      end
    end

    context 'when the last param is not a hash' do
      before do
        @args = [1, 'b']
      end

      it 'should return a new hash' do
        @client.extract_options!(@args).should eq({})
      end

      it 'should not remove the last item from the array' do
        size = @args.size
        @client.extract_options!(@args)
        @args.size.should == size
      end
    end
  end

end
