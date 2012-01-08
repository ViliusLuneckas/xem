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

  def to_n
    to_v
  end
end
