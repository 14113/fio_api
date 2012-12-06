module FioAPI
  # == Base class for deserializers. Should
  class Deserializer < FioAPI::Base

    # Deserialize method is required for every deserializer
    #
    # == Parameters:
    # hash::
    #   Hash returned form request
    #
    # == Returns:
    #   Should return new deserialized object
    #
    def deserialize(json)
      raise "Implement deserialize method"
    end

  end
end
