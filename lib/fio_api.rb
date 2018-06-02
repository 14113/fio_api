require "utils/hash"
require "base"
require "base/account"
require "base/transaction"
require "base/list"
require "base/request"

module FioAPI
  # == Returns:
  # A string with current version of gem
  #
  VERSION = "0.0.1"

  # Set API token for requests
  #
  # == Parameters:
  # token::
  #   Long string generated in Fio API banking application
  #
  # == Returns:
  #   Token
  #
  def self.token= token
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

