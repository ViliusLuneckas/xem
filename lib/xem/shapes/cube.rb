class Cube
  attr_accessor :size, :position, :color

  def initialize(size, options = {})
    self.size = size
    self.position = options[:position] || Point.new(0, 0, 0)
    self.color = options[:color] || :_000000
  end

  def draw
    xem = Xem::Xem.instance
    xem.in_separate_matrix do
      glTranslated(*position.to_a)
      xem.cube(size, color: color)
    end
  end

  def rectangle
    {
      top_left: {x: position.x + size, z: position.z},
      bottom_right: {x: position.x, z: position.z + size}
    }
  end
end
