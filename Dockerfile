FROM alpine:latest
RUN mkdir /app
WORKDIR /app
RUN apk update
RUN apk add make gcc cronie vim nano ruby-bundler ruby-nokogiri ruby-dev libc-dev libc6-compat
#RUN apt-get update && apt-get install make gcc cron vim nano
RUN rm -f /app/Gemfile.lock
COPY index.rb Gemfile .
COPY config ./config
RUN bundle install
CMD ["bundle","exec", "whenever", "--update-crontab"] 
