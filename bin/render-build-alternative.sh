#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Installing gems..."
bundle install

echo "Precompiling assets..."
RAILS_ENV=production bundle exec rails assets:precompile

echo "Cleaning old assets..."
RAILS_ENV=production bundle exec rails assets:clean

# For Render deployment, we need to handle database operations differently
# since the database might not be available during the build phase
echo "Preparing database (if available)..."
if RAILS_ENV=production bundle exec rails runner "ActiveRecord::Base.connection" 2>/dev/null; then
  echo "Database connection successful, running migrations..."
  RAILS_ENV=production bundle exec rails db:migrate
  
  echo "Seeding database (if not already seeded)..."
  RAILS_ENV=production bundle exec rails db:seed || true
else
  echo "Database not available during build phase"
  echo "Database operations will be handled after deployment"
fi

echo "Build completed successfully!"
