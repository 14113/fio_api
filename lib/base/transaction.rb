module FioAPI
  # == Transaction class representing the Transaction entity
  class Transaction < FioAPI::Base
    attr_accessor :transaction_id, :date, :amount, :currency, :account, :account_name, :bank_code,
      :bank_name, :ks, :vs, :ss, :user_identification, :message_for_recipient, :transaction_type,
      :sender, :detail_info, :comment, :bic, :action_id
  end
end
