#!/bin/bash
set -e

bundle install -j3 --path vendor/bundle

echo n | bundle exec rails init_db:setup

ruby -v

node -v

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
