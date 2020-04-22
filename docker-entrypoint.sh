#!/bin/sh

if [ "$1" = "test" ]; then
  export ENV=test
  set -e
  exec bundle exec rake
elif [ "$1" = "run" ]; then
  export RACK_ENV=production
  export ENV=production
  set -e
  exec bundle exec puma -p 8080 -e production
fi

exec "$@"
