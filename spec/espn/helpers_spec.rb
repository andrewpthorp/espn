require 'spec_helper'

class MockHelper
  include ESPN::Helpers
end

describe ESPN::Helpers do
  before do
    @helper = MockHelper.new
  end

  describe '#blank?' do
    it 'should be true for an empty string' do
      @helper.blank?('').should be_true
    end

    it 'should be false for a non empty string' do
      @helper.blank?('foo').should be_false
    end

    it 'should be true for a nil object' do
      @helper.blank?(nil).should be_true
    end

    it 'should be false for a non nil object' do
      @helper.blank?(Object.new).should be_false
    end
  end


end
