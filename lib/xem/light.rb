module Xem
  class Light
    attr_reader :position, :color

    def initialize(position = Point.new(0, 0, 0))
      @position = position
      @color = :_ddd380
    end

    def specular_light
    end

    protected

    def self.main_light
      @@main_light ||= Light.new
      glEnable(GL_LIGHT0)
      glLightfv(GL_LIGHT0, GL_AMBIENT, @@main_light.position.to_a << 1.0)
    end
  end

  class Xem
    attr_accessor :main_light

    def enable_lighting
      @@main_light = Light.new
      settings.set(:main_light, true)
    end

    def render_main_light
      Light.main_light if settings.get(:main_light)
    end

    chain :render_main_light, :after_clear
  end
end