FROM ruby:2.7.2-slim-buster AS base

ENV APP_DIR /app
WORKDIR ${APP_DIR}

# コンテナにexecしてrails consoleした時に、日本語が入力できなくなるため
# システムロケールを日本語に変更する
ENV LANG ja_JP.UTF-8
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update && \
    apt upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        curl \
        default-libmysqlclient-dev \
        nodejs \
        gnupg

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH ${PATH}:/root/.yarn/bin

ADD ./sample_app .
RUN gem update bundler
RUN bundle config set path 'vendor/bundle'
RUN bundle install
