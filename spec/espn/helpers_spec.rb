require 'spec_helper'

describe ESPN::Request do
  before do
    @client = ESPN::Client.new
  end

  describe '#extract_options_with_defaults!' do
    context 'when the last element of the first param is a hash' do
      before do
        @opts = { foo: 'bar' }
        @args = [1, 'b', @opts]
      end

      it 'should return that hash' do
        @client.extract_options_with_defaults!(@args).should eq(@opts)
      end

      it 'should remove that has from the array' do
        size = @args.size
        @client.extract_options_with_defaults!(@args)
        @args.size.should == size-1
      end
    end

    context 'when the last element of the first param is not a hash' do
      before do
        @args = [1, 'b']
      end

      it 'should return a new hash' do
        @client.extract_options_with_defaults!(@args).should eq({})
      end

      it 'should not remove the last item from the array' do
        size = @args.size
        @client.extract_options_with_defaults!(@args)
        @args.size.should == size
      end
    end

    context 'with defaults passed in' do
      it 'should set the defaults' do
        results = @client.extract_options_with_defaults!([], foo: 'bar')
        results[:foo].should eq('bar')
      end

      it 'should not override the original values' do
        results = @client.extract_options_with_defaults!([{foo: 'bar'}], foo: 'baz')
        results[:foo].should eq('bar')
      end
    end
  end

  describe '#blank?' do
    it 'should be true for an empty string' do
      @client.blank?('').should be_true
    end

    it 'should be false for a non empty string' do
      @client.blank?('foo').should be_false
    end

    it 'should be true for a nil object' do
      @client.blank?(nil).should be_true
    end

    it 'should be false for a non nil object' do
      @client.blank?(Object.new).should be_false
    end
  end


end
