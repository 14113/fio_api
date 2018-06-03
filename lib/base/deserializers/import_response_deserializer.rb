require 'httparty'

module FioAPI
  # == ImportResponseDeserializer
  # Deserializer responsible for response json deserializing. Should construct object with status attributes.
  #
  class ImportResponseDeserializer < HTTParty::Parser
    attr_accessor :status

    # Parse json
    #
    # == Returns:
    #   Should return new deserialized object
    #
    def parse
      deserialize super
    end

    # Deserialize json
    #
    # == Parameters:
    # hash::
    #   Hash returned from payments request.
    #
    # == Returns:
    #   New object with status attributes
    #
    def deserialize(json)
      self.status = deserialize_import(json.try_path("responseImport", "result"))
      self
    end

    private

    # Deserialize import of payments
    # == Parameters:
    # response_json::
    #   Hash with informations about payments
    # == Returns:
    #   Status
    def deserialize_import(response_json)
      FioAPI::Payments::Status.new(
        error_code: response_json.try_path("errorCode").to_i,
        error_message: response_json.try_path('message').to_s,
        id_instruction: response_json.try_path("idInstruction").to_i,
        sum_credit: response_json.try_path("sums","sum","sumCredit").to_f,
        sum_debet: response_json.try_path("sums", "sum", "sumDebet").to_f
      )
    end
  end
end
