FROM ruby:3.0.0-alpine
MAINTAINER sam.snafu@gmail.com

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    git \
    nodejs-current \
    yarn \
    tzdata

ARG USER
ARG HOME
ARG UID

RUN apk add --update \
    sudo

RUN echo "Welcome home: $USER => $UID"

RUN adduser -S -D -G users -u $UID $USER
RUN addgroup -S sudo
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sudo 
RUN adduser $USER sudo

RUN echo "Welcome home: $USER"

ENV APP_HOME ${HOME}

WORKDIR ${HOME}

COPY Gemfile* ${HOME}/

RUN gem install bundler:2.2.15
RUN bundle install
RUN sudo gem install standalone_migrations

COPY . .

# CMD ruby ./bin/start
ENTRYPOINT ["sh", "./entrypoint.sh"]
