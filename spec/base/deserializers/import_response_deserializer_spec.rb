require_relative '../../spec_helper'

describe FioAPI::ImportResponseDeserializer do
  describe 'instance attributes' do
    it 'should respond to status' do
      expect(FioAPI::ImportResponseDeserializer.new('{}', '')).to respond_to(:status)
    end
  end

  describe 'deserialization' do
    before(:each) do
      @deserializer = FioAPI::ImportResponseDeserializer.new('{}', '')
    end

    it 'deserialize valid payment status' do
      status_json = {
        'errorCode' => '0', 'idInstruction' => '153935923', 'status' => 'ok', 'sums' => {
          'sum' => { 'sumCredit' => '0', 'sumDebet' => '100.0', 'id' => 'CZK' }
        }
      }

      result = { error_code: 0, id_instruction: 153_935_923, sum_credit: 0.0, sum_debet: 100.0, error_message: '' }
      deserialized = @deserializer.send(:deserialize_import, status_json)
      result.each do |attr_name, value|
        expect(deserialized.send(attr_name)).to eq(value)
      end
    end

    it 'deserialize invalid payment status' do
      status_json = {
        'errorCode' => '11', 'status' => 'error', 'message' => 'Error message'
      }

      result = { error_code: 11, id_instruction: 0, sum_credit: 0.0, sum_debet: 0.0, error_message: 'Error message' }
      deserialized = @deserializer.send(:deserialize_import, status_json)
      result.each do |attr_name, value|
        expect(deserialized.send(attr_name)).to eq(value)
      end
    end
  end
end
