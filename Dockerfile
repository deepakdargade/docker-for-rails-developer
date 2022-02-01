FROM ruby:2.6

RUN apt-get update 
RUN apt-get install -yqq --no-install-recommends nodejs

COPY . /usr/src/app

WORKDIR /usr/src/app
RUN bundle install