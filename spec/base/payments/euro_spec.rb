require_relative '../../spec_helper'

describe FioAPI::Payments::Euro do
  describe 'instance attributes' do
    %i[
      account_from currency amount account_to ks vs ss bic
      date comment
    ].each do |attr|
      it "should respond to #{attr}" do
        expect(FioAPI::Payments::Euro.new).to respond_to(attr)
      end
    end
  end
end
