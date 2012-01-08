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

  def color
    @@colors ||= {}
    @@colors[self] ||= calculate_color
  end

  protected

  # :xff00ff -> [1.0, 0.0, 1.0], x - any character
  def calculate_color
    hex_code = to_s
    [ hex_code[1, 2].hex / 255.0, hex_code[3, 2].hex / 255.0, hex_code[5, 2].hex / 255.0 ]
  end
end
