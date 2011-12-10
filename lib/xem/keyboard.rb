module Xem
  class Keyboard
    attr_accessor :xem, :keys

    def initialize(xem)
      @xem = xem
      @keys = {}
    end

    def event(key, action)
      @keys[key] = action
      respond_to(key, action)
    end

    def camera_hooks
      xem.camera.move(:forward) if keys['W'] == 1 || keys[283] == 1
      xem.camera.move(:backward) if keys['S'] == 1 || keys[284] == 1
      xem.camera.move(:left) if keys['A'] == 1 || keys[285] == 1
      xem.camera.move(:right) if keys['D'] == 1 || keys[286] == 1
    end

    protected

    def respond_to(key, action)
      case key
        when 257
          xem.shutdown
        else
          code = key.is_a?(String) ? key.bytes.first : key
          #p "Key that doesn't mean anything was pressed (ascii: #{key}, code: #{code})" unless action.zero?
      end
    end
  end
end