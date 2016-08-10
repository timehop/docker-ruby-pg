FROM ruby:2.1.9
MAINTAINER Timehop Infrastructure <infra@timehop.com>

############################
# rails postgres dependencies
#---------------------------
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main 9.5" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
# libpq-dev is required for the pg gem
RUN apt-get install -y libpq-dev postgresql-client-9.5

RUN mkdir /app
WORKDIR /app