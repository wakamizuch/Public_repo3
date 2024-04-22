FROM ruby:3.1.4

COPY ./rails_project/Gemfile /rails_project/Gemfile
COPY ./rails_project/Gemfile.lock /rails_project/Gemfile.lock

WORKDIR /rails_project

RUN gem update --system
RUN bundle update --bundler
RUN bundle install
