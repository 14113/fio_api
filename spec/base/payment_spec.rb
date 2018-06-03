require_relative "../spec_helper"

describe FioAPI::Payment do
  before(:each) do
    @payment = FioAPI::Payments::Domestic.new(account_from: '11111111', currency: 'CZK', amount: amount, account_to: '22222222', bank_code: '3030', date: '2018-06-15')
    @service = FioAPI::Payment.new [@payment]
  end

  context 'payment with valid data' do
    let(:amount) { 100.0 }
    it "should make request" do
      VCR.use_cassette 'import', erb: true do
        expect(@service.import).to be_a HTTParty::Response
        expect(@service.request).to be_a HTTParty::Response
        expect(@service.response).to be_a FioAPI::ImportResponseDeserializer
      end
    end

    it "should build path" do
      expect(@service.path).to eq "/import/?token=#{FioAPI.token}&type=xml"
    end
  end

  context 'payment with invalid data' do
    let(:amount) { '' }
    it "should make request" do
      VCR.use_cassette 'invalid_import', erb: true do
        expect(@service.import).to be_a HTTParty::Response
        expect(@service.request).to be_a HTTParty::Response
        expect(@service.response).to be_a FioAPI::ImportResponseDeserializer
      end
    end

    it "should build path" do
      expect(@service.path).to eq "/import/?token=#{FioAPI.token}&type=xml"
    end
  end
end
