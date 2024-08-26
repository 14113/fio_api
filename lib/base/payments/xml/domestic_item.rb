module FioAPI
  module Payments
    module Xml
      class DomesticItem < ItemBase
        attr_reader :builder, :payment

        def build
          @build ||= builder.DomesticTransaction do
            create_element('accountFrom', payment.account_from)
            create_element('currency', payment.currency)
            create_element('amount', payment.amount)
            create_element('accountTo', payment.account_to)
            create_element('bankCode', payment.bank_code)
            maybe_create_element('ks', payment.ks)
            maybe_create_element('vs', payment.vs)
            maybe_create_element('ss', payment.ss)
            create_element('date', payment.date)
            maybe_create_element('messageForRecipient', payment.message_for_recipient)
            maybe_create_element('comment', payment.comment)
            maybe_create_element('paymentReason', payment.payment_reason)
            maybe_create_element('paymentType', payment.payment_type)
          end
        end
      end
    end
  end
end
