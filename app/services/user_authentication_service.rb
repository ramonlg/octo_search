require 'json_web_token'

class UserAuthenticationService
  private_class_method :new

  def self.call(username, password)
    new(username, password).call
  end

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    result
  end

  private

  attr_accessor :username, :password

  def result
    return error_response unless success?

    success_response
  end

  def success?
    user && user.authenticate(password)
  end

  def web_token
    JsonWebToken.encode(user_id: user.id)
  end

  def user
    @user ||= User.find_by(username: username)
  end

  def success_response
    { content: {
        auth_token: web_token
      },
      status: :ok
    }
  end

  def error_response
    {
      content: {
        error: { user_authentication: "Invalid username or password" }
      },
      status: :unauthorized
    }
  end
end