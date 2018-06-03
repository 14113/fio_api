module FioAPI
  # Base class for request to transactions listing and account information
  class List < FioAPI::Base
    attr_accessor :request, :response

    # Allow request transactions in date range
    #
    # == Parameters:
    # from_date::
    #   Start date for transactions list
    # to_date::
    #   End date for transactions list
    #
    # == Returns:
    #   List insatnce with account info and transactions list
    #
    # https://www.fio.cz/ib_api/rest/periods/(token)/(date_from)/(date_to)/transactions.(format)
    def by_date_range(from_date, to_date)
      fetch_and_deserialize_response("/periods/#{FioAPI.token}/#{from_date}/#{to_date}/transactions.json")
    end

    # Allow request transactions by listing_id and year
    #
    # == Parameters:
    # listing_id::
    #   Id of listing
    # year::
    #   Year when listing was provided
    #
    # == Returns:
    #   List insatnce with account info and transactions list
    #
    # https://www.fio.cz/ib_api/rest/by-id/(token)/(year)/(id)/transactions.(format)
    def by_listing_id_and_year(listing_id, year)
      fetch_and_deserialize_response("/by-id/#{FioAPI.token}/#{year}/#{listing_id}/transactions.json")
    end

    # Allow request transactions from last request
    #
    # == Returns:
    #   List insatnce with account info and transactions list
    #
    # https://www.fio.cz/ib_api/rest/last/(token)/transactions.(format)
    def from_last_fetch
      fetch_and_deserialize_response("/last/#{FioAPI.token}/transactions.json")
    end

    # Allow request to set last transaction_id
    #
    # == Parameters:
    # transaction_id::
    #   Id of transaction
    #
    # == Returns:
    #   List insatnce with account info and transactions list
    #
    # https://www.fio.cz/ib_api/rest/set-last-id/(token)/(id)/
    def set_last_fetch_id(transaction_id)
      fetch_and_deserialize_response("/set-last-id/#{FioAPI.token}/#{transaction_id}/")
    end

    # Allow request to set last request date
    #
    # == Parameters:
    # date::
    #   Date when last request was provided
    #
    # == Returns:
    #   List insatnce with account info and transactions list
    #
    # https://www.fio.cz/ib_api/rest/set-last-date/(token)/(rrrr-mm-dd)/
    def set_last_fetch_date(date)
      fetch_and_deserialize_response("/set-last-date/#{FioAPI.token}/#{date}/")
    end

    private

    # Create request object ot provided uri and instantiate list deserializer.
    # Request uri and deserialize response to response object with account info and transactions list.
    #
    # == Parameters:
    # args::
    #   Parts of uri
    #
    # == Returns:
    #   List insatnce with account info and transactions list
    #
    def fetch_and_deserialize_response(path)
      self.request = FioAPI::Request.get(path, :parser=>ListResponseDeserializer)
      self.response = self.request.parsed_response
      self.request
    end

  end
end
