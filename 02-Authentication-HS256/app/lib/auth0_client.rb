# frozen_string_literal: true

require 'jwt'
require 'net/http'

# Auth0Client class to handle JWT token validation
class Auth0Client

  # Auth0 Client Objects
  Error = Struct.new(:message, :status)
  Response = Struct.new(:decoded_token, :error)

  Token = Struct.new(:token) do
    def validate_permissions(permissions)
      required_permissions = Set.new permissions
      scopes = token[0]['scope']
      token_permissions = scopes.present? ? Set.new(scopes.split(" ")) : Set.new
      required_permissions <= token_permissions
    end
  end

  # Helper Functions
  def self.domain_url
    "https://#{Rails.configuration.auth0.domain}/"
  end

  def self.decode_token(token)
    JWT.decode(token,
               Rails.configuration.auth0.signing_secret,
               true, # Verify the signature of this token
               { algorithm: 'HS256',
                 iss: domain_url,
                 verify_iss: true,
                 aud: Rails.configuration.auth0.audience,
                 verify_aud: true })
  end

  # Token Validation
  def self.validate_token(token)
    decoded_token = decode_token(token)

    Response.new(Token.new(decoded_token), nil)
  rescue JWT::VerificationError, JWT::DecodeError
    error = Error.new('Bad credentials', :unauthorized)
    Response.new(nil, error)
  end
end
