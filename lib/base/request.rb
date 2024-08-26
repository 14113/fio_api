require 'httparty'

module FioAPI
  class Request < FioAPI::Base
    include HTTParty

    base_uri 'https://fioapi.fio.cz/v1/rest/'

    class << self
      # Reader for token
      def token
        @@token
      end

      # Setter for token
      def token=(token)
        @@token = token
      end
    end
  end
end
