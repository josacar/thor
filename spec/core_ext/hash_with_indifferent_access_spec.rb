require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'thor/core_ext/hash_with_indifferent_access'

describe Thor::CoreExt::HashWithIndifferentAccess do
  before(:each) do
    @hash = Thor::CoreExt::HashWithIndifferentAccess.new 'foo' => 'bar', 'baz' => 'bee', 'force' => true
  end
  
  it "has values accessible by either strings or symbols" do
    @hash['foo'].must == 'bar'
    @hash[:foo].must  == 'bar'
    @hash.values_at(:foo, :baz).must == ['bar', 'bee']
  end
  
  it "should handles magic boolean predicates" do
    @hash.force?.must be_true
    @hash.foo?.must be_true
    @hash.nothing?.must be_false
  end
  
  it "should map methods to keys: hash.foo => hash[:foo]" do
    @hash.foo.must == @hash['foo']
  end
  
  it "should map setters to keys: hash.foo=bar => hash[:foo] => bar" do
    @hash.foo = :bar2
    @hash.foo.must == :bar2
  end
end