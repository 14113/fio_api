require_relative "../spec_helper"

describe FioAPI::Request do

  it "should have defined token" do
    FioAPI::Request.should respond_to :token
  end

  it "should have defined uri" do
    FioAPI::Request.new.should respond_to :uri
  end

  it "should have defined response" do
    FioAPI::Request.new.should respond_to :response
  end

  describe "fetch" do
    before(:each) do
      @response = {response: "response"}
      HTTParty.stub(:get) { @response }
    end

    it "should fill the response" do
      request = FioAPI::Request.new
      request.fetch
      request.response.should eq @response
    end

    it "should deserialize the response" do
      deserializer = FioAPI::ListResponseDeserializer.new
      request = FioAPI::Request.new(deserializer: deserializer)
      request.fetch
      request.response.should eq deserializer.deserialize(@response)
    end
  end

  describe "uri manipulation" do
    before(:each) do
      FioAPI.token = "somelongtoken"
      @url = "https://www.fio.cz/ib_api/rest/#{FioAPI.token}/transactions.json"
      @request = FioAPI::Request.new
    end

    it "should construct uri from arguments" do
      @request.send(:construct_uri, FioAPI.token, 'transactions.json').to_s.should eq @url
    end

    it "should set uri from arguments" do
      @request.set_uri FioAPI.token, 'transactions.json'
      @request.uri.should eq @url
    end

  end
end
