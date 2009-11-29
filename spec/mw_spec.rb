$:.unshift File.dirname(__FILE__) + '/../lib'
require 'mw'

describe 'mw' do
  it 'calls with a arg' do
    Kernel::MEOW_INSTANCE.should_receive(:notify).with($0, 'foo'.pretty_inspect, :priority => 0)
    mw 'foo'
  end

  it 'calls with args' do
    Kernel::MEOW_INSTANCE.should_receive(:notify).twice
    mw 'foo', 'bar'
  end

  it 'calls without args' do
    Kernel::MEOW_INSTANCE.should_receive(:notify).with($0, nil.pretty_inspect, :priority => 0)
    mw
  end

  it 'should return original args' do
    mw('foo').should         == 'foo'
    mw('foo', 'bar').should  == ['foo', 'bar']
    mw().should              == nil
  end
end

describe 'mw1' do
  it "should calls notify method with priority=-2" do
    Kernel::MEOW_INSTANCE.should_receive(:notify).with($0, 'foo'.pretty_inspect, :priority => -2)
    mw1 'foo'
  end
end

describe 'mw2' do
  it "should calls notify method with priority=-1" do
    Kernel::MEOW_INSTANCE.should_receive(:notify).with($0, 'foo'.pretty_inspect, :priority => -1)
    mw2 'foo'
  end
end

describe 'mw4' do
  it "should calls notify method with priority=1 and sticky=true" do
    Kernel::MEOW_INSTANCE.should_receive(:notify).with($0, 'foo'.pretty_inspect, :priority => 1, :sticky => true)
    mw4 'foo'
  end
end

describe 'mw5' do
  it "should calls notify method with priority=2" do
    Kernel::MEOW_INSTANCE.should_receive(:notify).with($0, 'foo'.pretty_inspect, :priority => 2, :sticky => true)
    mw5 'foo'
  end
end

