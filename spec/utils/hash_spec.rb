require_relative "../spec_helper"

describe Hash do

  describe "try_path" do

    it "should respond to try_path method" do
      expect({}).to respond_to(:try_path)
    end

    it "should return nil if can't find key" do
      expect({}.try_path("key1", "key2")).to be_nil
    end

    it "should return value on path" do
      expect({"key1" => {"key2" => "value"} }.try_path("key1", "key2")).to eq "value"
    end
  end
end

describe NilClass do

  describe "try_path" do

    it "should respond to try_path method" do
      expect(nil).to respond_to(:try_path)
    end

    it "should return nil" do
      expect(nil.try_path("key1", "key2")).to be_nil
    end

  end
end
