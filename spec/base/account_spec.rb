require_relative "../spec_helper"

describe FioAPI::Account do

  describe "instance attributes" do

    [:account_id, :bank_id, :currency, :iban,:bic,:opening_balance,:closing_balance,
    :date_start, :date_end, :year_list, :id_list, :id_from, :id_to, :id_last_download].each do |attr|

      it "should respond to #{attr}" do
        FioAPI::Account.new.should respond_to(attr)
      end

    end
  end

end
