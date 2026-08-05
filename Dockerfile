FROM ruby:3.3.12-slim-bookworm

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle \
    PATH="/bundle/bin:${PATH}" \
    RAILS_ENV=development \
    BUNDLE_APP_CONFIG=/bundle

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libpq-dev git curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
