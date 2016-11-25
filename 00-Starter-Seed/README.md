# Auth0 + Ruby on Rails API Seed
This is the seed project to create an API with Ruby on Rails. If you want to build a Ruby On Rails WebApp, please check this [other seed project](https://github.com/auth0-samples/auth0-rubyonrails-sample/tree/master/00-Starter-Seed)

You can learn more about this seed project in the [Auth0 Rails quickstart](https://auth0.com/docs/quickstart/backend/rails).

# Running the Seed Application
In order to run the example you need to have ruby installed.

You also need to set the Domain, API Signing Secret and Audience for your Auth0 app as environment variables with the following names respectively: `AUTH0_CLIENT_ID`, `AUTH0_API_SIGNING_SECRET` and `AUTH0_AUDIENCE`.

Set the environment variables in `.env` to match those your Auth0 Client.

````bash
# .env file
AUTH0_DOMAIN=samples.auth0.com
AUTH0_API_SIGNING_SECRET=myCoolSecret
AUTH0_AUDIENCE=myAudience

````
## Used Libraries
* [Ruby JWT](https://github.com/jwt/ruby-jwt)
