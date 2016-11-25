# Authentication RS256
[Full Tutorial](https://auth0.com/docs/quickstart/backend/rails/01-authentication-RS256)

This example shows how to secure your Rails API using RS256 signed, Auth0-issued JSON Web Tokens.

## Running the Sample Application
In order to run the example you need to have Ruby installed.

You also need to set the Domain, and API Audience for your Rails API as environment variables with the following names respectively: `AUTH0_DOMAIN` and `AUTH0_AUDIENCE`.

Set the environment variables in `.env` to match those in your Auth0 API.

````bash
# .env file
AUTH0_DOMAIN="myAuth0Domain"
AUTH0_AUDIENCE=myAPIAudience
````
Once you've set these environment variables, run `bundle install` and then `rails s`. You can follow the instructions in the [Full Tutorial](https://auth0.com/docs/quickstart/backend/rails/01-authentication-RS256) to an access token and then call the secured API endpoint.
__Note:__ Remember that you need to have `./bin` in your path for `rails s` to work.

Shut it down manually with Ctrl-C.

__Note:__ If you are using Windows, uncomment the `tzinfo-data` gem in the gemfile.

## Important Snippets

### 1. Auth0 Lock Setup
[JsonWebToken Decode Method Code](/01-Authentication-RS256/lib/json_web_token.erb)
```ruby
class JsonWebToken
  def self.decode(token)
    JWT.decode(token, nil,
               true, # Verify the signature of this token
               algorithm: 'RS256',
               iss: Rails.application.secrets.auth0_domain,
               verify_iss: true,
               aud: Rails.application.secrets.auth0_api_audience,
               verify_aud: true) do |header|
      jwks_hash[header['kid']]
    end
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI("#{Rails.application.secrets.auth0_domain}.well-known/jwks.json")
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    Hash[
      jwks_keys
      .map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k['x5c'].first)
          ).public_key
        ]
      end
    ]
  end
end
```

## Used Libraries
* [Ruby JWT](https://github.com/jwt/ruby-jwt)
