# Auth0 + Ruby on Rails API Sample


# Installation

Start by renaming the `.env.example` file to `.env` and provide the Auth0 client ID, domain, and client secret for your app.

Run `bundle install`, then run `rails s`. The app will be served at [http://localhost:3000/ping](http://localhost:3000/ping).

Make a `GET` request to [http://localhost:3000/secured/ping](http://localhost:3000/secured/ping). This route will throw an error if you don't send a valid JWT in the `Authorization` header of the request.

__Note:__ If you need to enable cross-origin resource sharing, check out the [rack-cors](https://github.com/cyu/rack-cors) gem.

__Note:__ If you are using Windows, add the `tzinfo-data` gem to the gemfile.
