require_relative "../../spec_helper"

describe FioAPI::Payments::Status do

  describe "instance attributes" do
    [
      :error_code, :id_instruction, :error_message, :sum_credit, :sum_debet
    ].each do |attr|
      it "should respond to #{attr}" do
        expect(FioAPI::Payments::Status.new).to respond_to(attr)
      end
    end
  end
end
