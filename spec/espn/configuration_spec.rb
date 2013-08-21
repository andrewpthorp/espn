require 'spec_helper'

describe ESPN::Configuration do

  describe '.constants' do
    it { should be_const_defined('VALID_OPTIONS_KEYS') }
    it { should be_const_defined('DEFAULT_ADAPTER') }
    it { should be_const_defined('DEFAULT_API_VERSION') }
    it { should be_const_defined('DEFAULT_USER_AGENT') }
    it { should be_const_defined('DEFAULT_TIMEOUT') }
  end

  describe '#reset' do
   ESPN::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should reset #{key}" do
        ESPN.should_receive("#{key}=")
        ESPN.reset
      end
    end
  end

  describe '#options' do
    ESPN::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should include :#{key}" do
        ESPN.options.should include(key)
      end
    end
  end

end
