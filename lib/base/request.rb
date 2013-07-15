require 'httparty'

module FioAPI
  class Request < FioAPI::Base
    # Consant of base part of uri for requesting
    BASE_URI = "https://www.fio.cz/ib_api/rest/"

    class << self

      # Reader for token
      def token
        @@token
      end

      # Setter for token
      def token= token
        @@token = token
      end
    end

    attr_accessor :uri, :response_json, :deserializer

    # Make request to uri
    #
    # == Returns:
    #   Request instance
    #
    def fetch
      self.response_json = HTTParty.get(uri).to_hash
      self
    end

    # Set uri for request
    #
    # == Parameters:
    # args::
    #   Parts of uri
    #
    # == Returns:
    #   Uri string
    #
    def set_uri(*args)
      self.uri = construct_uri(*args)
    end

    # Reader for request response
    #
    # == Returns:
    #   Response as a JSON or a deserialilzed response. Depends if the deserializer is set
    #
    def response
      @response ||= deserializer ? deserializer.deserialize(response_json) : response_json
    end

    private

    # Uri constructor
    #
    # == Parameters:
    # args::
    #   Parts of uri
    #
    # == Returns:
    #   Uri string
    #
    def construct_uri(*args)
      url_parts = args.map(&:to_s).join("/")
      URI::join(BASE_URI, url_parts).to_s
    end
  end
end
