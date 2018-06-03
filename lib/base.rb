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
    def initialize(*hash)
      hash.first.each { |k, v| send("#{k}=", v) } if hash.length == 1 && hash.first.is_a?(Hash)
    end
  end
end
