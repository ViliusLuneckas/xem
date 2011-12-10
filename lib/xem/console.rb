module Xem
  class Console
    attr_reader :xem
    
    def initialize(xem)
      @xem = xem
      @visible = false
    end
    
    def toggle
      visible? ? hide : show
    end

    def show
      @visible = true
    end

    def hide
      @visible = false
    end

    def visible?
      @visible
    end

    def draw
    end
  end

  class Xem
    attr_reader :console    
    
    def enable_console
      settings.set(:console, true)
      @console ||= Console.new(self)
    end
  end
end
