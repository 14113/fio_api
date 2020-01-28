module FioAPI
  module Payments
    # == Euro class representing the Euro entity
    class Euro < FioAPI::Base
      attr_accessor :account_from, :currency, :amount, :account_to, :ks, :vs, :ss, :bic,
                    :date, :comment,
                    :beneficiary_name, :beneficiary_street, :beneficiary_city, :beneficiary_country,
                    :remittance_info1, :remittance_info2, :remittance_info3,
                    :payment_reason

      def payment_type
        '431008'
      end

      def xml_item_class
        Xml::EuroItem
      end
    end
  end
end
