module Xem
  module Extendings
    def alias_method_chain(method, extension)
      alias_method "#{method}_without_#{extension}", method
      alias_method method, "#{method}_with_#{extension}"
    end

    def chain(method, old_method)
      define_method "#{old_method}_with_#{method}" do
        send("#{old_method}_without_#{method}")
        send(method)
      end

      alias_method_chain old_method, method
    end
  end
end

class Symbol
  def to_v
    case self
      when :y, :up
        [0, 1, 0]
      when :down
        [0, -1, 0]
      when :left, :west
        [-1, 0, 0]
      when :right, :east, :x
        [1, 0, 0]
      when :forward, :north
        [0, 0, -1]
      when :backward, :south, :z
        [0, 0, 1]
      when :zero
        [0, 0, 0]
      else
        [0, 0, 0]
    end
  end
end

class Array
  def inverse
    collect { |e| -e }
  end

  def move(options = {})
    new_ary = self

    options[:right].times do
      new_ary = new_ary.collect { |e| [e[0] + Xem::Constants::X_INTERVAL, e[1]] }
    end if options[:right]

    options[:down].times do
      new_ary = new_ary.collect { |e| [e[0], e[1] + Xem::Constants::Y_INTERVAL] }
    end if options[:down]

    new_ary
  end
end
