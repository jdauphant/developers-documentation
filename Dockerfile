FROM ruby:2.6.1

ENV BUNDLE_PATH ./gems

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN gem install bundler

CMD bundle exec jekyll serve --watch --incremental --host 0.0.0.0 --port 4310
