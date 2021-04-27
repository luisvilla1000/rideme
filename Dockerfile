FROM ruby:2.7.3

LABEL maintainer="luisvilla1000@gmail.com"

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5
COPY . /usr/src/app/

EXPOSE 9292

CMD ["thin", "-p", "9292", "start"]