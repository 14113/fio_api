require_relative "../spec_helper"

describe Hash do

  describe "try_path" do

    it "should respond to try_path method" do
      {}.should respond_to(:try_path)
    end

    it "should return nil if can't find key" do
      {}.try_path("key1", "key2").should be_nil
    end

    it "should return value on path" do
      {"key1" => {"key2" => "value"} }.try_path("key1", "key2").should eq "value"
    end
  end
end

describe NilClass do

  describe "try_path" do

    it "should respond to try_path method" do
      nil.should respond_to(:try_path)
    end

    it "should return nil" do
      nil.try_path("key1", "key2").should be_nil
    end

  end
end
