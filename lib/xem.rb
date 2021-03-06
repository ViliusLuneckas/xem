require 'opengl'
require 'glfw'


require_relative 'ext/ext.rb'
require_relative 'xem/constants'
require_relative 'xem/helpers'
require_relative 'xem/cache'
require_relative 'xem/xem'

module Xem
  class Xem
    extend Extendings
    include Helpers
    include Cache
  end
end

require_relative 'xem/sky_box'
require_relative 'xem/metrics'
require_relative 'xem/camera'
require_relative 'xem/mouse'
require_relative 'xem/keyboard'
require_relative 'xem/settings'
require_relative 'xem/font_manager'
require_relative 'xem/console'
require_relative 'xem/simple_draw'
require_relative 'xem/shapes/shapes.rb'
require_relative 'xem/light.rb'
require_relative 'xem/collision_machine.rb'

