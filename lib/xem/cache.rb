module Xem
  module Cache
    def cache(&block)
      @cached ||= {}
      key = block.source_location.join(':').to_sym
      @cached[key] ? glCallList(@cached[key]) : cache_block(key) { yield }
    end

    protected

    def cache_block(key)
      list_id = glGenLists(1)
      glNewList(list_id, GL_COMPILE)
      yield
      glEndList
      @cached[key] = list_id
    end
  end
end