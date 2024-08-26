require_relative '../spec_helper'

describe FioAPI::List do
  before(:each) do
    @list = FioAPI::List.new
  end

  it 'should set request with uri for date range' do
    date_from = Date.new(2011, 1, 1)
    date_to = Date.new(2012, 11, 25)
    url = "https://fioapi.fio.cz/v1/rest/periods/#{FioAPI.token}/#{date_from}/#{date_to}/transactions.json"
    VCR.use_cassette 'by_date_range', erb: true do
      list = @list.by_date_range(date_from, date_to)
      expect(list.request.uri.to_s).to eq url
      expect(list.transactions.length).to eq 1
    end
  end

  it 'should set request with uri for listing_id and year' do
    year = 2012
    id = '12345'
    url = "https://fioapi.fio.cz/v1/rest/by-id/#{FioAPI.token}/#{year}/#{id}/transactions.json"
    VCR.use_cassette 'by_listing_id_and_year', erb: true do
      list = @list.by_listing_id_and_year(id, year)
      expect(list.request.uri.to_s).to eq url
      expect(list.transactions.length).to eq 0
    end
  end

  it 'should set request with uri from last fetch' do
    url = "https://fioapi.fio.cz/v1/rest/last/#{FioAPI.token}/transactions.json"
    VCR.use_cassette 'from_last_fetch', erb: true do
      list = @list.from_last_fetch
      expect(list.request.uri.to_s).to eq url
      expect(list.transactions.length).to eq 0
    end
  end

  it 'should set request with uri to set last fetch id' do
    id = '12345'
    url = "https://fioapi.fio.cz/v1/rest/set-last-id/#{FioAPI.token}/#{id}/"
    VCR.use_cassette 'set_last_fetch_id', erb: true do
      list = @list.set_last_fetch_id(id)
      expect(list.request.uri.to_s).to eq url
      expect(list.transactions.length).to eq 0
    end
  end

  it 'should set request with uri to set last date' do
    date = Date.new(2012, 11, 25)
    url = "https://fioapi.fio.cz/v1/rest/set-last-date/#{FioAPI.token}/#{date}/"
    VCR.use_cassette 'set_last_fetch_date', erb: true do
      list = @list.set_last_fetch_date(date)
      expect(list.request.uri.to_s).to eq url
      expect(list.transactions.length).to eq 0
    end
  end
end
