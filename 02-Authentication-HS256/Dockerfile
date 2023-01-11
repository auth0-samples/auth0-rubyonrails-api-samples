FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
ADD .ruby-version /myapp/.ruby-version
ENV BUNDLER_VERSION 2.3.26
RUN gem install bundler -v ${BUNDLER_VERSION} && bundle install --jobs 20 --retry 5
ADD . /myapp
CMD /myapp/bin/rails s -b 0.0.0.0 -p 3010
EXPOSE 3010
