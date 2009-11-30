require 'rubygems'
require 'meow'
require 'pp'

module Kernel
  MEOW_INSTANCE = Meow.new('Kernel.mw')
  def mw(*things)
    args, opts =
      if things[-1].kind_of?(Hash) && things[-1].has_key?(:priority)
        [things[0..-2], things[-1]]
      else
        [things, {:priority => 0}]
      end
    messages =
      if args.empty?
        [nil.pretty_inspect]
      else
        args.map { |i| i.pretty_inspect }
      end
    messages.each { |i| MEOW_INSTANCE.notify $0, i, opts}

    if args.empty?
      nil
    elsif args.size == 1
      args.first
    else
      args
    end
  end

  def tapmw
    tap { mw block_given? ? yield(self) : self }
  end

  def mw1(*args)
    args << {:priority => -2}
    mw(*args)
  end
  alias :mw_debug :mw1

  def mw2(*args)
    args << {:priority => -1}
    mw(*args)
  end
  alias :mw_info :mw2

  alias :mw3 :mw

  def mw4(*args)
    args << {:priority => 1, :sticky => true}
    mw(*args)
  end
  alias :mw_warn :mw4

  def mw5(*args)
    args << {:priority => 2, :sticky => true}
    mw(*args)
  end
  alias :mw_error :mw5
end
