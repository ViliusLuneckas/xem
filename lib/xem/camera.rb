require_relative 'point'

module Xem
  class Camera
    attr_reader :xem, :position, :angle, :view_distance, :look_around_speed, :vertical_angle
    attr_accessor :speed

    def initialize(xem)
      @xem = xem
      @position = Point.new(0, 1.8, 0)
      @angle = Point.new(0, 0, 0)
      @view_distance = 1000
      @look_around_speed = 0.06
      @vertical_angle = (-90..85)
      self.speed = 3
    end

    def look_around(diff)
      @angle += diff * look_around_speed
      @angle.y %= 360
      unless vertical_angle.include?(angle.x)
        angle.x = if angle.x > 0 and angle.x > vertical_angle.last
          vertical_angle.last
        else
          vertical_angle.first
        end
      end
    end

    def step
      speed / xem.fps
    end

    def move(direction)
      y_rot = angle.y / 180.0 * Math::PI
      x_rot = angle.x / 180.0 * Math::PI

      diff = case direction
               when :forward
                 Point.new(Math::sin(y_rot) * step, -Math::sin(x_rot) * step, -Math::cos(y_rot) * step)
               when :backward
                 Point.new(-Math::sin(y_rot) * step, Math::sin(x_rot) * step, Math::cos(y_rot) * step)
               when :left
                 Point.new(-Math::cos(y_rot) * step, 0, -Math::sin(y_rot) * step)
               when :right
                 Point.new(Math::cos(y_rot) * step, 0, Math::sin(y_rot) * step)
               else
                 raise 'Bad moving direction'
             end
      make_move(diff)
    end

    protected

    def make_move(diff)
      @position += diff
    end
  end
end
