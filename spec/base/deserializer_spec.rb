require_relative "../spec_helper"

describe FioAPI::Deserializer do

  describe "deserialize" do

    it "should raise exception" do
      expect { FioAPI::Deserializer.new.deserialize }.to raise_error
    end

  end
end
