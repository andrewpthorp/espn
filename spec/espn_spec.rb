require 'spec_helper'

describe ESPN do

  describe '.new' do
    it 'should be a new ESPN::Client' do
      ESPN.new.should be_a ESPN::Client
    end
  end

  describe '.method_missing' do
    before do
      @mock_espn = double('ESPN')
      ESPN.stub(:new).and_return(@mock_espn)
    end

    it 'should call super if ESPN::Client does not respond to the method' do
      @mock_espn.stub(:respond_to?).with(:to_s).and_return(false)
      @mock_espn.should_not_receive(:to_s)
      ESPN.to_s
    end

    it 'should send the method to a new ESPN::Client if it responds' do
      @mock_espn.stub(:respond_to?).with(:foobar).and_return(true)
      @mock_espn.should_receive(:send).with(:foobar)
      ESPN.foobar
    end
  end

  describe '.respond_to?' do
    it 'should be true if the method exists' do
      ESPN.respond_to?(:new).should be_true
    end

    it 'should be false if the method does not exist' do
      ESPN.respond_to?(:foobaryo).should be_false
    end
  end

end
