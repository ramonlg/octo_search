class JsonWebToken
  class << self
    def encode(payload, exp = 6.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]

      HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError
      nil
    end
  end
end
