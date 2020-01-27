module FioAPI
  module Payments
    module Xml
      class EuroItem < ItemBase
        attr_reader :builder, :payment

        def build
          @build ||= builder.T2Transaction do
            create_element('accountFrom', payment.account_from)
            create_element('currency', payment.currency)
            create_element('amount', payment.amount)
            create_element('accountTo', payment.account_to)
            maybe_create_element('ks', payment.ks)
            maybe_create_element('vs', payment.vs)
            maybe_create_element('ss', payment.ss)
            maybe_create_element('bic', payment.bic)
            create_element('date', payment.date)
            maybe_create_element('comment', payment.comment)
            create_element('benefName', payment.beneficiary_name)
            maybe_create_element('benefStreet', payment.beneficiary_street)
            maybe_create_element('benefCity', payment.beneficiary_city)
            maybe_create_element('benefCountry', payment.beneficiary_country)
            maybe_create_element('remittanceInfo1', payment.remittance_info1)
            maybe_create_element('remittanceInfo2', payment.remittance_info2)
            maybe_create_element('remittanceInfo3', payment.remittance_info3)
            maybe_create_element('paymentReason', payment.payment_reason)
            maybe_create_element('paymentType', payment.payment_type)
          end
        end
      end
    end
  end
end
