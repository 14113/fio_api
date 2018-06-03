module FioAPI
  module Payments
    module Xml
      class Item
        attr_reader :builder, :payment

        def initialize(builder, payment)
          @builder = builder
          @payment = payment
        end

        def build
          @build ||= builder.DomesticTransaction do
            builder.accountFrom payment.account_from
            builder.currency payment.currency
            builder.amount payment.amount
            builder.accountTo payment.account_to
            builder.bankCode payment.bank_code
            builder.ks payment.ks
            builder.vs payment.vs
            builder.ss payment.ss
            builder.date payment.date
            builder.messageForRecipient payment.message_for_recipient
            comment
            builder.paymentType payment.payment_type
          end
        end

        private

        def create_element(name, value = '')
          builder.parent.add_child builder.doc.create_element(name, value)
        end

        def comment
          create_element('comment', payment.comment)
        end
      end
    end
  end
end
