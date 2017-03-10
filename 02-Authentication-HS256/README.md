# Authentication HS256
[Full Tutorial](https://auth0.com/docs/quickstart/backend/rails/02-authentication-HS256)

This example shows how to secure your Rails API using HS256 signed, Auth0-issued JSON Web Tokens.

## Running the Sample Application
In order to run the example you need to have Ruby installed.

You also need to set the Domain, API Signing Secret, and API Audience for your Rails API as environment variables with the following names respectively: `AUTH0_DOMAIN`, `AUTH0_SIGNING_SECRET`, and `AUTH0_AUDIENCE`.

Set the environment variables in `.env` to match those in your Auth0 API.

````bash
# .env file
AUTH0_DOMAIN="myAuth0Domain"
AUTH0_SIGNING_SECRET=myAPISigningSecret
AUTH0_AUDIENCE=myAPIAudience
````
Once you've set these environment variables, run `bundle install` and then `rails s`. You can follow the instructions in the [Full Tutorial](https://auth0.com/docs/quickstart/backend/rails/02-authentication-HS256) to an access token and then call the secured API endpoint.
__Note:__ Remember that you need to have `./bin` in your path for `rails s` to work.

Shut it down manually with Ctrl-C.

__Note:__ If you are using Windows, uncomment the `tzinfo-data` gem in the gemfile.

## Important Snippets

### 1. Auth0 Lock Setup
[JsonWebToken Decode Method Code](/01-Authentication-HS256/lib/json_web_token.erb)
```ruby
class JsonWebToken

  def self.decode(token)
    JWT.decode token,  Rails.application.secrets.auth0_api_signing_secret,
    true, # Verify the signature of this token
    algorithm: 'HS256',
    iss: Rails.application.secrets.auth0_domain,
    verify_iss: true,
    aud: Rails.application.secrets.auth0_api_audience,
    verify_aud: true
  end
end
```

## Used Libraries
* [Ruby JWT](https://github.com/jwt/ruby-jwt)
