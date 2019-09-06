FROM ruby:2.5.5-alpine

# TODO: what was this for?
VOLUME ["/var/www/requisition/downloads"]

RUN mkdir -p /var/www/requisition/ \
  && apk update \
  && apk add \
    build-base \
    nodejs \
    postgresql-dev \
    tzdata \
    yarn \
  && cp /usr/share/zoneinfo/UTC /etc/localtime \
  && echo "UTC" > /etc/timezone \
  && gem install bundler

ARG RAILS_ENV
ENV RAILS_ENV="${RAILS_ENV:-development}" \
    RAILS_LOG_TO_STDOUT="true" \
    RAILS_SERVE_STATIC_FILES="true"

WORKDIR /var/www/requisition/
COPY Gemfile* /var/www/requisition/
RUN echo "RAILS_ENV: $RAILS_ENV"; \
  if [ $RAILS_ENV == "production" ]; \
  then bundle install --without=development,test,deploy,doc; \
  else bundle install; \
  fi

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE="${SECRET_KEY_BASE}"

COPY . /var/www/requisition/
RUN ["bundle", "exec", "rails", "assets:precompile", "--trace"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

EXPOSE 3000
