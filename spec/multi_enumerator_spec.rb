require 'spec_helper'

describe MultiEnumerator do

  it "iterates over given enumerators" do
    a = [1, 2, 3].each
    b = [10, 20].each
    c = [30].each
    result = MultiEnumerator.build(a, b, c).each.to_a
    result[0].should == [1, 10, 30]
    result[1][0..1].should == [2, 20]
    result[2][0].should == 3
    result[1][2].class.should == StopIteration
    result[2][1..2].map(&:class).uniq.should == [StopIteration]
  end

  it "iterates over given enumerators, filling tails" do
    a = [1, 2, 3].each
    b = [10, 20].each
    c = [30].each
    result = MultiEnumerator.build([a, b, c], :ljust_with => nil).each.to_a
    result[0].should == [1, 10, 30]
    result[1][0..1].should == [2, 20]
    result[2][0].should == 3
    result[1][2].should == nil
    result[2][1..2].uniq.should == [nil]
  end

  it "respects :rewind option" do
    enum = [1,2,3].each
    enum.next
    result = MultiEnumerator.build(enum, :rewind => false).each.to_a
    result.should == [2, 3]
  end

  it "is inspectable" do
    MultiEnumerator.build([].each).inspect
  end
end