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
        FioAPI::Payments::Domestic.new
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
      <ks/>
      <vs/>
      <ss/>
      <date>2018-06-15</date>
      <messageForRecipient/>
      <comment/>
      <paymentType>431001</paymentType>
    </DomesticTransaction>
    <DomesticTransaction>
      <accountFrom/>
      <currency/>
      <amount/>
      <accountTo/>
      <bankCode/>
      <ks/>
      <vs/>
      <ss/>
      <date/>
      <messageForRecipient/>
      <comment/>
      <paymentType>431001</paymentType>
    </DomesticTransaction>
  </Orders>
</Import>
      XML
    end
  end
end
