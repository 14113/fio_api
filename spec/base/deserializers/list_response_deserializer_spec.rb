require_relative "../../spec_helper"

describe FioAPI::ListResponseDeserializer do

  describe "instance attributes" do

    it "should respond to account" do
      expect(FioAPI::ListResponseDeserializer.new('{}','')).to respond_to(:account)
    end

    it "should respond to transactions" do
      expect(FioAPI::ListResponseDeserializer.new('{}','')).to respond_to(:transactions)
    end

  end

  describe "deserialization" do
    before(:each) do
      @deserializer = FioAPI::ListResponseDeserializer.new('{}','')
    end

    it "deserialize account info" do
      account_json = { "accountId" => "26457567988", "bankId" => "2010", "currency" => "CZK",
        "iban" => "CZ03345356456702600147988", "bic" => "FIOBCZPPXXX", "openingBalance" => 0.0, "closingBalance" => 11669.96,
        "dateStart" => "2011-01-01+0100", "dateEnd" => "2012-12-26+0100", "yearList" => 2012, "idList" => 353434,
        "idFrom" => 1145645683284, "idTo" => 1167566706, "idLastDownload" => 234234234234
      }

      result = { :account_id => "26457567988", :bank_id => "2010", :currency => "CZK", :iban => "CZ03345356456702600147988",
        :bic => "FIOBCZPPXXX", :opening_balance => 0.0, :closing_balance => 11669.96, :date_start => "2011-01-01+0100",
        :date_end => "2012-12-26+0100", :year_list => 2012, :id_list => 353434, :id_from => 1145645683284,
        :id_to => 1167566706, :id_last_download => 234234234234 }

      deserialized =  @deserializer.send(:deserialize_account, account_json)

      result.each do |attr_name,value|
        expect(deserialized.send(attr_name)).to eq(value)
      end
    end



    it "deserialize transaction info" do
      transaction_json = {
        "column22" => { "value" => 1148734530, "name" => "ID pohybu", "id" => 22},
        "column0" => { "value" => 1340661600000, "name" => "Datum", "id" => 0},
        "column1" => { "value" => 1, "name" => "Objem", "id" => 1 },
        "column14" => { "value" => "CZK", "name" => "Mena", "id" => 14 },
        "column2" => { "value" => "2900233333", "name" => "Protiucet", "id" => 2 },
        "column10" => { "value" => "Pavel, Novak", "name" => "Nazev protiuctu", "id" => 10},
        "column3" => { "value" => "2010", "name" => "Kod banky", "id" => 3},
        "column12" => { "value" => "Fio banka, a.s.", "name" => "Nazev banky", "id" => 12 },
        "column4" => { "value" => "0558", "name" => "KS", "id" => 4 },
        "column5" => { "value" => "0558345345345", "name" => "VS", "id" => 5 },
        "column6" => { "value" => "055234", "name" => "SS", "id" => 6 },
        "column7" => { "value" => "Prikaz", "name" => "Identifikace uzivatelem", "id" => 7 },
        "column16" => { "value" => "Prikaz pro tomase", "name" => "Zprava pro prijemce", "id" => 16 },
        "column8" => { "value" => "Prijem prevodem uvnitr banky", "name" => "Typ", "id" => 8 },
        "column9" => { "value" => "Robin Bortlik", "name" => "Odesilatel", "id" => 9 },
        "column18" => { "value" => "Detail info", "name" => "Detailni informace", "id" => 18 },
        "column25" => { "value" => "Text", "name" => "Komentar", "id" => 25 },
        "column26" => { "value" => "345790", "name" => "BIC", "id" => 26 },
        "column17" => { "value" => 2105685816, "name" => "ID pokynu", "id" => 17}
      }

      result = {:date => 1340661600000, :amount => 1, :currency => "CZK", :account => "2900233333",
        :account_name => "Pavel, Novak", :bank_code => "2010", :bank_name => "Fio banka, a.s.",
        :ks => "0558", :vs => "0558345345345", :ss => "055234", :user_identification => "Prikaz",
        :message_for_recipient => "Prikaz pro tomase", :transaction_type => "Prijem prevodem uvnitr banky",
        :sender => "Robin Bortlik", :detail_info => "Detail info", :comment => "Text", :bic => "345790",
        :action_id => 2105685816}

      deserialized = @deserializer.send(:deserialize_transactions, [transaction_json])[0]

      result.each do |attr_name,value|
        expect(deserialized.send(attr_name)).to eq(value)
      end
    end

    it "should return deserializer object with account and transactions" do
      @deserializer.deserialize({"accountStatement" => {"transactionList" => {"transaction" => [{}] }}} )
      expect(@deserializer.account.class).to eq FioAPI::Account
      expect(@deserializer.transactions.class).to eq Array
      expect(@deserializer.transactions.first.class).to eq FioAPI::Transaction
    end
  end
end





