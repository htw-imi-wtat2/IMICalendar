FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /imical
WORKDIR /imical
ADD Gemfile /imical/Gemfile
ADD Gemfile.lock /imical/Gemfile.lock
RUN bundle install
ADD . /imical
