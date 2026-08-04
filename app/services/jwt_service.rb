class JwtService
  SECRET_KEY = Rails.application.secret_key_base || "default_jwt_secret_key"

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    # Simplified JWT encoding
    Base64.urlsafe_encode64(payload.to_json)
  end

  def self.decode(token)
    decoded_json = Base64.urlsafe_decode64(token)
    HashWithIndifferentAccess.new(JSON.parse(decoded_json))
  rescue StandardError => e
    nil
  end
end
