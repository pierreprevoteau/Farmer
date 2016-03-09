FROM ruby:2.2.3

RUN apt-get update && apt-get install -y wget apt-transport-https
RUN wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo 'deb https://deb.nodesource.com/node_0.12 jessie main' > /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install -y nodejs

WORKDIR /app

# Mostly static
ADD config.ru /app/
ADD Rakefile /app/
ADD bin /app/bin
ADD public /app/public
ADD db /app/db

# Gems
ADD Gemfile /app/
ADD Gemfile.lock /app/
RUN bundle install

# Code
ADD config /app/config
ADD app /app/app
ADD lib /app/lib

EXPOSE 9080

CMD bundle exec puma -C ./config/puma.rb
