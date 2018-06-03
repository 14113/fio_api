require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe FioAPI do
  it 'should setup token' do
    token = 'some token'
    FioAPI.token = token
    expect(FioAPI::Request.token).to eq token
  end

  it 'should return token' do
    token = 'some token'
    FioAPI::Request.token = token
    expect(FioAPI.token).to eq token
  end
end
