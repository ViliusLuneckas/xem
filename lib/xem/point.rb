class Point
  attr_accessor :x, :y, :z

  def initialize(x, y, z = 0)
    self.x, self.y, self.z = x, y, z
  end

  def to_s
    "(#{'%.2f' % x}; #{'%.2f' % y}; #{'%.2f' % z})"
  end

  def -(other)
    Point.new(x - other.x, y - other.y, z - other.z)
  end

  def +(other)
    Point.new(x + other.x, y + other.y, z + other.z)
  end

  def *(other)
    if other.is_a?(Numeric)
      result = Point.new(x * other, y * other, z * other)
    end
  end
end