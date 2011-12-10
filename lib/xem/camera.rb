require_relative 'point'

module Xem
  class Camera
    attr_reader :xem, :position, :angle, :view_distance

    def initialize(xem)
      @xem = xem
      @position = Point.new(0, 0, 0)
      @angle = Point.new(0, 0, 0)
      @view_distance = 1000
    end
  end
end