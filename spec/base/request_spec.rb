require_relative '../spec_helper'

describe FioAPI::Request do
  it 'should have defined token' do
    expect(FioAPI::Request).to respond_to :token
  end
end
