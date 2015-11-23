require_relative "../spec_helper"

describe FioAPI::Request do

  it "should have defined token" do
    expect(FioAPI::Request).to respond_to :token
  end

  it "should have defined uri" do
    expect(FioAPI::Request.new).to respond_to :uri
  end

  it "should have defined response" do
    expect(FioAPI::Request.new).to respond_to :response
  end

  describe "fetch" do
    before(:each) do
      @response = {response: "response"}
      allow(HTTParty).to receive(:get) { @response }
    end

    it "should fill the response" do
      request = FioAPI::Request.new
      request.fetch
      expect(request.response).to eq @response
    end

    it "should deserialize the response" do
      deserializer = FioAPI::ListResponseDeserializer.new
      request = FioAPI::Request.new(deserializer: deserializer)
      request.fetch
      expect(request.response).to eq deserializer.deserialize(@response)
    end
  end

  describe "uri manipulation" do
    before(:each) do
      FioAPI.token = "somelongtoken"
      @url = "https://www.fio.cz/ib_api/rest/#{FioAPI.token}/transactions.json"
      @request = FioAPI::Request.new
    end

    it "should construct uri from arguments" do
      expect(@request.send(:construct_uri, FioAPI.token, 'transactions.json').to_s).to eq @url
    end

    it "should set uri from arguments" do
      @request.set_uri FioAPI.token, 'transactions.json'
      expect(@request.uri).to eq @url
    end

  end
end
