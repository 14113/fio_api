module FioAPI
  module Payments
    # == Status class representing the Status entity
    class Status < FioAPI::Base
      attr_accessor :error_code, :id_instruction, :error_message, :sum_credit, :sum_debet
    end
  end
end
