require 'spec_helper'

describe ESPN::Arguments do
  before do
    @arguments = ESPN::Arguments.new([])
  end

  it 'should have an options reader' do
    @arguments.respond_to?(:options).should be_true
  end

  it 'should not have an options writer' do
    @arguments.respond_to?(:options=).should be_false
  end

  it 'should default options to an empty hash' do
    @arguments.options.delete(:sport)
    @arguments.options.delete(:league)
    @arguments.options.should eq({})
  end

  it 'should extract options' do
    @arguments = ESPN::Arguments.new([{ foo: 'bar' }])
    @arguments.options.delete(:sport)
    @arguments.options.delete(:league)
    @arguments.options.should eq({foo: 'bar'})
  end

  it 'should extract sport' do
    @arguments = ESPN::Arguments.new([:baseball])
    @arguments.options[:sport].should eq('baseball')
  end

  it 'should extract league mapped to a sport' do
    @arguments = ESPN::Arguments.new([:mlb])
    @arguments.options.should eq({sport: 'baseball', league: 'mlb'})
  end

  it 'should extract sport and league' do
    @arguments = ESPN::Arguments.new([:football, :mlb])
    @arguments.options.should eq({sport: 'football', league: 'mlb'})
  end

  context 'when passing default values' do
    it 'should set default values' do
      @arguments = ESPN::Arguments.new([{sport: 'baseball'}], league: 'mlb')
      @arguments.options.should eq({sport: 'baseball', league: 'mlb'})
    end

    it 'should not override non-nil values' do
      @arguments = ESPN::Arguments.new([{sport: 'baseball'}], sport: 'football')
      @arguments.options[:sport].should eq('baseball')
    end
  end

end
