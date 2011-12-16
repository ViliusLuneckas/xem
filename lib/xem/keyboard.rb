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

    def ascii_event(key, action)
      ascii_key = [key].pack('c*')
      xem.console.ascii_press(ascii_key) if xem.settings.get(:console) and xem.console.visible? and not action.zero?
      xem.console.toggle if ascii_key == '`' and xem.settings.get(:console) and not action.zero? 
    end

    def camera_hooks
      xem.camera.move(:forward) if keys['W'] == 1 || keys[283] == 1
      xem.camera.move(:backward) if keys['S'] == 1 || keys[284] == 1
      xem.camera.move(:left) if keys['A'] == 1 || keys[285] == 1
      xem.camera.move(:right) if keys['D'] == 1 || keys[286] == 1
    end

    protected

    def respond_to(key, action)
      xem.console.non_ascii_press(key) if xem.settings.get(:console) and xem.console.visible? and not key.is_a?(String) and not action.zero?
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
