require_relative "../../spec_helper"

describe FioAPI::Payments::Domestic do

  describe "instance attributes" do
    [
      :account_from, :currency, :amount, :account_to, :bank_code, :ks, :vs, :ss,
      :date, :message_for_recipient, :comment
    ].each do |attr|
      it "should respond to #{attr}" do
        expect(FioAPI::Payments::Domestic.new).to respond_to(attr)
      end
    end
  end
end
