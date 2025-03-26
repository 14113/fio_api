require 'utils/hash'
require 'tempfile'
require 'base'
require 'base/account'
require 'base/transaction'
require 'base/list'
require 'base/request'
require 'base/payment'
require 'base/payments/status'
require 'base/payments/domestic'
require 'base/payments/xml/root'
require 'base/payments/xml/item'
require 'base/deserializers/list_response_deserializer'
require 'base/deserializers/import_response_deserializer'
require 'base/errors/invalid_json_response'

module FioAPI
  # == Returns:
  # A string with current version of gem
  #
  VERSION = '0.0.10'.freeze

  # Set API token for requests
  #
  # == Parameters:
  # token::
  #   Long string generated in Fio API banking application
  #
  # == Returns:
  #   Token
  #
  def self.token=(token)
    FioAPI::Request.token = token
  end

  # Get API token
  #
  # == Returns:
  #   Token from gem configuration
  #
  def self.token
    FioAPI::Request.token
  end
end
