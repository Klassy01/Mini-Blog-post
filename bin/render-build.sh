#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing gems..."
bundle install

echo "Precompiling assets..."
bundle exec rake assets:precompile

echo "Cleaning old assets..."
bundle exec rake assets:clean

echo "Running database migrations..."
bundle exec rake db:migrate

echo "Seeding database (if not already seeded)..."
bundle exec rake db:seed || true

echo "Build completed successfully!" 