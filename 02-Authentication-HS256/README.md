# Authentication HS256
[Full Tutorial](https://auth0.com/docs/quickstart/backend/rails)

This example shows how to secure your Rails API using HS256 signed, Auth0-issued JSON Web Tokens.

## Running the Sample Application
In order to run the example you need to have Ruby installed.

You also need to set the Domain, API Signing Secret, and API Audience for your Rails API as environment variables with the following names respectively: `AUTH0_DOMAIN`, `AUTH0_SIGNING_SECRET`, and `AUTH0_API_AUDIENCE`.

Set the environment variables in `.env` to match those in your Auth0 API.

````bash
# .env file
AUTH0_DOMAIN="myAuth0Domain"
AUTH0_SIGNING_SECRET=myAPISigningSecret
AUTH0_API_AUDIENCE=myAPIAudience
````
Once you've set these environment variables, run `bundle install` and then `rails s`. You can follow the instructions in the [Full Tutorial](https://auth0.com/docs/quickstart/backend/rails/02-authentication-HS256) to create an access token and then call the secured API endpoint.
__Note:__ Remember that you need to have `./bin` in your path for `rails s` to work.

Shut it down manually with Ctrl-C.

__Note:__ If you are using Windows, uncomment the `tzinfo-data` gem in the gemfile.

## Running the Sample Application With Docker

In order to run the example with docker you need to have `docker` installed.

You also need to set the client credentials as explained [previously](#running-the-sample-application).

Execute in command line `sh exec.sh` to run the Docker in Linux, or `.\exec.ps1` to run the Docker in Windows.

## Important Snippets

### 1. Auth0 Lock Setup
[Auth0Client Validate Token Method Code](/01-Authentication-HS256/app/lib/auth0_client.rb)
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
```

## Used Libraries
* [Ruby JWT](https://github.com/jwt/ruby-jwt)
