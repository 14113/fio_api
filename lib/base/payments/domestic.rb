module FioAPI
  module Payments
    # == Domestic class representing the Domestic entity
    class Domestic < FioAPI::Base
      attr_accessor :account_from, :currency, :amount, :account_to, :bank_code, :ks, :vs, :ss,
                    :date, :message_for_recipient, :comment

      def payment_type
        '431001'
      end
    end
  end
end
