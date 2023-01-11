# Authentication RS256
[Full Tutorial](https://auth0.com/docs/quickstart/backend/rails/01-authorization)

This example shows how to secure your Rails API using RS256 signed, Auth0-issued JSON Web Tokens.

## Running the Sample Application

In order to run the example you need to have Ruby installed.

You also need to set the Domain, and API Audience for your Rails API as environment variables with the following names respectively: `AUTH0_DOMAIN` and `AUTH0_API_AUDIENCE`.

Set the environment variables in `.env` to match those in your Auth0 API.

````bash
# .env file
AUTH0_DOMAIN="myAuth0Domain"
AUTH0_API_AUDIENCE=myAPIAudience
````
Once you've set these environment variables, run `bundle install` and then `rails s --port 3010`. You can follow the instructions in the [Full Tutorial](https://auth0.com/docs/quickstart/backend/rails/01-authentication-RS256) to create an access token and then call the secured API endpoint.
__Note:__ Remember that you need to have `./bin` in your path for `rails s` to work.

Shut it down manually with Ctrl-C.

__Note:__ If you are using Windows, uncomment the `tzinfo-data` gem in the gemfile.

## Running the Sample Application With Docker

In order to run the example with docker you need to have `docker` installed.

You also need to set the client credentials as explained [previously](#running-the-sample-application).

Execute in command line `sh exec.sh` to run the Docker in Linux, or `.\exec.ps1` to run the Docker in Windows.

## Important Snippets

### 1. Auth0 Lock Setup
[Auth0Client Validate Token Method Code](/01-Authentication-RS256/app/lib/auth0_client.rb)
```ruby
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

  def self.decode_token(token, jwks_hash)
    JWT.decode(token, nil, true, {
                 algorithm: 'RS256',
                 iss: domain_url,
                 verify_iss: true,
                 aud: Rails.configuration.auth0.audience,
                 verify_aud: true,
                 jwks: { keys: jwks_hash[:keys] }
               })
  end

  def self.get_jwks
    jwks_uri = URI("#{domain_url}.well-known/jwks.json")
    Net::HTTP.get_response jwks_uri
  end

  # Token Validation 
  def self.validate_token(token)
    jwks_response = get_jwks

    unless jwks_response.is_a? Net::HTTPSuccess
      error = Error.new(message: 'Unable to verify credentials', status: :internal_server_error)
      return Response.new(nil, error)
    end

    jwks_hash = JSON.parse(jwks_response.body).deep_symbolize_keys

    decoded_token = decode_token(token, jwks_hash)

    Response.new(Token.new(decoded_token), nil)
  rescue JWT::VerificationError, JWT::DecodeError => e
    error = Error.new('Bad credentials', :unauthorized)
    Response.new(nil, error)
  end
end
```

## Used Libraries
* [Ruby JWT](https://github.com/jwt/ruby-jwt)
