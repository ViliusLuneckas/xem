module Xem
  class Keyboard
    attr_accessor :xem, :keys

    def initialize(xem)
      @xem = xem
      @keys = {}
    end

    def event(key, action)
      @keys[key] = action
      respond_to(key)
    end

    protected

    def respond_to(key)
      xem.shutdown if key == 257
    end
  end
end