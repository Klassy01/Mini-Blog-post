#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing gems..."
bundle install

echo "Precompiling assets..."
bundle exec rails assets:precompile

echo "Cleaning old assets..."
bundle exec rails assets:clean

# Database operations - only run if DATABASE_URL is available
if [ -n "$DATABASE_URL" ]; then
  echo "Running database migrations..."
  bundle exec rails db:migrate
  
  echo "Seeding database (if not already seeded)..."
  bundle exec rails db:seed || true
else
  echo "DATABASE_URL not available, skipping database operations"
  echo "Database operations will be handled by Render after service startup"
fi

echo "Build completed successfully!" 