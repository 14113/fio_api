module FioAPI
  module Payments
    # == Domestic class representing the Domestic entity
    class Domestic < FioAPI::Base
      attr_accessor :account_from, :currency, :amount, :account_to, :bank_code, :ks, :vs, :ss,
                    :date, :message_for_recipient, :comment, :payment_reason

      def payment_type
        '431001'
      end

      def xml_item_class
        Xml::DomesticItem
      end
    end
  end
end
