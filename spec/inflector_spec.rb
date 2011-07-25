require 'spec_helper'

module Beatport 
  describe Inflector do
    describe '.process_keys' do
      it "should transform all keys to camel case" do
        h1 = {:key_one => 'a', :key_two => { :key_three => 'b'}}
        h2 = {"KeyOne" => "a", "KeyTwo" => { "KeyThree" => "b"}}
        
        Inflector.process_keys(h1) { |k| Inflector.camelize(k.to_s) }.should == h2
        Inflector.process_keys(h2) { |k| Inflector.underscore(k.to_s).to_sym }.should == h1
      end
    end
  end
end