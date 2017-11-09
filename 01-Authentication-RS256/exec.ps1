docker build -t auth0-rubyonrails-api-rs256 .
docker run --env-file .env -p 3000:3000 -it auth0-rubyonrails-api-rs256
