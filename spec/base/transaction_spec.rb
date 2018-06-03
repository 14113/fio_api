require_relative '../spec_helper'

describe FioAPI::Transaction do
  describe 'instance attributes' do
    %i[transaction_id date amount currency account account_name bank_code
       bank_name ks vs ss user_identification message_for_recipient transaction_type
       sender detail_info comment bic action_id].each do |attr|

      it "should respond to #{attr}" do
        expect(FioAPI::Transaction.new).to respond_to(attr)
      end
    end
  end
end
