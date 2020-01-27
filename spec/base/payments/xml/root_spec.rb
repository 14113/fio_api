require_relative '../../../spec_helper'

describe FioAPI::Payments::Xml::Root do
  let(:payments) { [] }
  let(:service) { FioAPI::Payments::Xml::Root.new(payments) }

  context 'build xml without payments' do
    it 'returns empty xml' do
      expect(service.build).to eq <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<Import xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.fio.cz/schema/importIB.xsd">
  <Orders/>
</Import>
      XML
    end
  end

  context 'build xml with payments' do
    let(:payments) do
      [
        FioAPI::Payments::Domestic.new(account_from: '11111111', currency: 'CZK', amount: 123.1, account_to: '22222222', bank_code: '3030', date: '2018-06-15'),
        FioAPI::Payments::Domestic.new,
        FioAPI::Payments::Euro.new(account_from: '12345678', currency: 'EUR', amount: 12.34, account_to: 'SK121234123412341234', date: '2018-06-15'),
        FioAPI::Payments::Euro.new,
      ]
    end
    it 'returns empty xml' do
      expect(service.build).to eq <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<Import xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.fio.cz/schema/importIB.xsd">
  <Orders>
    <DomesticTransaction>
      <accountFrom>11111111</accountFrom>
      <currency>CZK</currency>
      <amount>123.1</amount>
      <accountTo>22222222</accountTo>
      <bankCode>3030</bankCode>
      <date>2018-06-15</date>
      <paymentType>431001</paymentType>
    </DomesticTransaction>
    <DomesticTransaction>
      <accountFrom/>
      <currency/>
      <amount/>
      <accountTo/>
      <bankCode/>
      <date/>
      <paymentType>431001</paymentType>
    </DomesticTransaction>
    <T2Transaction>
      <accountFrom>12345678</accountFrom>
      <currency>EUR</currency>
      <amount>12.34</amount>
      <accountTo>SK121234123412341234</accountTo>
      <date>2018-06-15</date>
      <benefName/>
      <paymentType>431008</paymentType>
    </T2Transaction>
    <T2Transaction>
      <accountFrom/>
      <currency/>
      <amount/>
      <accountTo/>
      <date/>
      <benefName/>
      <paymentType>431008</paymentType>
    </T2Transaction>
  </Orders>
</Import>
      XML
    end
  end
end
