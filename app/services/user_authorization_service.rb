require 'json_web_token'

class UserAuthorizationService
  private_class_method :new

  def self.call(headers = {})
    new(headers).call
  end

  def initialize(headers)
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return nil unless headers['Authorization'].present?

    headers['Authorization'].split(' ').last
  end
end
