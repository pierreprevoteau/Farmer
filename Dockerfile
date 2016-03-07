FROM ruby:latest
ENV HOME /home/rails/webapp
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR $HOME
ADD Gemfile* $HOME/
RUN bundle install
ADD . $HOME
CMD ["rails", "server", "--binding", "0.0.0.0”]
