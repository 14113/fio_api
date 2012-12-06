module FioAPI
  # == ListResponseDeserializer
  # Deserializer responsible for response json deserializing. Should construct object with account and transactions attributes.
  #
  class ListResponseDeserializer < FioAPI::Deserializer
    attr_accessor :account, :transactions

    # Deserialize json
    #
    # == Parameters:
    # hash::
    #   Hash returned from list request.
    #
    # == Returns:
    #   New object with account and transactions attributes
    #
    def deserialize(json)
      self.account = deserialize_account(json.try_path("accountStatement", "info"))
      self.transactions = deserialize_transactions(json.try_path("accountStatement", "transactionList", "transaction"))
      self
    end

    private

    # Deserialize account info
    # == Parameters:
    # account_json::
    #   Hash with informations obout account
    # == Returns:
    #   Account object
    def deserialize_account(account_json)
      FioAPI::Account.new(
        account_id:       account_json.try_path("accountId"),
        bank_id:          account_json.try_path("bankId"),
        currency:         account_json.try_path("currency"),
        iban:             account_json.try_path("iban"),
        bic:              account_json.try_path("bic"),
        opening_balance:  account_json.try_path("openingBalance"),
        closing_balance:  account_json.try_path("closingBalance"),
        date_start:       account_json.try_path("dateStart"),
        date_end:         account_json.try_path("dateEnd"),
        year_list:        account_json.try_path("yearList"),
        id_list:          account_json.try_path("idList"),
        id_from:          account_json.try_path("idFrom"),
        id_to:            account_json.try_path("idTo"),
        id_last_download: account_json.try_path("idLastDownload")
      )
    end

    # Deserialize list of transactions
    # == Parameters:
    # transactions_json::
    #   Hash with informations obout transactions
    # == Returns:
    #   Array of transactions
    def deserialize_transactions(transactions_json)
      Array(transactions_json).map do |trans_json|
        FioAPI::Transaction.new(
          transaction_id:         trans_json.try_path("column22", "value"),
          date:                   trans_json.try_path("column0", "value"),
          amount:                 trans_json.try_path("column1", "value"),
          currency:               trans_json.try_path("column14", "value"),
          account:                trans_json.try_path("column2", "value"),
          account_name:           trans_json.try_path("column10", "value"),
          bank_code:              trans_json.try_path("column3", "value"),
          bank_name:              trans_json.try_path("column12", "value"),
          ks:                     trans_json.try_path("column4", "value"),
          vs:                     trans_json.try_path("column5", "value"),
          ss:                     trans_json.try_path("column6", "value"),
          user_identification:    trans_json.try_path("column7", "value"),
          message_for_recipient:  trans_json.try_path("column16", "value"),
          transaction_type:       trans_json.try_path("column8", "value"),
          sender:                 trans_json.try_path("column9", "value"),
          detail_info:            trans_json.try_path("column18", "value"),
          comment:                trans_json.try_path("column25", "value"),
          bic:                    trans_json.try_path("column26", "value"),
          action_id:              trans_json.try_path("column17", "value")
        )
      end
    end
  end
end
