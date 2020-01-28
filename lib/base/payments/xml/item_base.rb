module FioAPI
  module Payments
    module Xml
      class ItemBase
        attr_reader :builder, :payment

        def initialize(builder, payment)
          @builder = builder
          @payment = payment
        end

        private

        def maybe_create_element(name, value)
          create_element(name, value) if value
        end

        def create_element(name, value = '')
          builder.parent.add_child builder.doc.create_element(name, value)
        end
      end
    end
  end
end
