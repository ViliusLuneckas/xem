module Xem
  module Extendings
    def alias_method_chain(method, extension)
      alias_method "#{method}_without_#{extension}", method
      alias_method method, "#{method}_with_#{extension}"
    end

    def chain(method, old_method)
      define_method "#{old_method}_with_#{method}" do
        send("#{old_method}_without_#{method}")
        send(method)
      end

      alias_method_chain old_method, method
    end
  end
end
