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
