module FioAPI
  # Base class for submit payments and waiting for authorization
  class Payment
    attr_accessor :request, :response, :payments

    def initialize(payments)
      @payments = [payments].flatten
    end

    def path
      "/import/?token=#{FioAPI.token}&type=xml"
    end

    def import
      self.request ||= FioAPI::Request.post(path, headers: headers, body: { 'file' => file }, parser: FioAPI::ImportResponseDeserializer)
      self.response ||= self.request.parsed_response
      self.request
    end

    def success?
      response.status.error_code.zero?
    end

    private

    def headers
      {
        'Content-Type' => 'multipart/form-data',
        'boundary' => '-----------RubyMultipartPost'
      }
    end

    def xml
      FioAPI::Payments::Xml::Root.new(payments).build
    end

    def file
      file = Tempfile.new('fio')
      file.write xml
      file.rewind
      file
    end
  end
end
