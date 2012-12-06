module FioAPI
  # == Account class representing the Account entity
  class Account < FioAPI::Base
    attr_accessor :account_id, :bank_id, :currency, :iban,:bic,:opening_balance,:closing_balance,
      :date_start, :date_end, :year_list, :id_list, :id_from, :id_to, :id_last_download
  end
end
