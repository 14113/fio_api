module FioAPI
  class Base
    # Allow ruby object to be initialized with params
    #
    # == Parameters:
    # hash::
    #   Hash where key is attribute and value is new attribute value
    #
    # == Returns:
    #   New object with prefilled attributes
    #
    def initialize(*h)
      if h.length == 1 && h.first.kind_of?(Hash)
        h.first.each { |k,v| send("#{k}=",v) }
      end
    end

  end
end

