FROM ruby:latest
RUN mkdir /app
WORKDIR /app
RUN apt-get update && apt-get install make gcc cron vim nano -y && apt-get clean
RUN rm -f /app/Gemfile.lock
COPY index.rb Gemfile .
COPY config ./config
RUN bundle install
CMD ["bundle","exec", "whenever", "--update-crontab"] 
