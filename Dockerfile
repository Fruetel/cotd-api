FROM ruby:2.7.0-slim

RUN apt-get update && \
  apt-get install --no-install-recommends -y git build-essential postgresql-client wget && rm -rf /var/lib/apt/lists/*

RUN groupadd -r app -g 1000
RUN useradd -u 1000 -r -g app -m -s /sbin/nologin app

WORKDIR /code

COPY Gemfile /code
COPY Gemfile.lock /code
RUN chown -R app:app /code/

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

USER app
RUN gem install bundler
RUN bundle install
USER root
RUN apt-get purge -y --auto-remove build-essential
USER app

COPY . /code

USER root
RUN chown -R app:app /code/
USER app

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["run"]
