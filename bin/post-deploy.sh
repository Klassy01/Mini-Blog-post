#!/usr/bin/env bash
# Post-deployment setup script for Render
# This should be run after the application is deployed

echo "Running post-deployment setup..."

# Ensure database is created and migrated
echo "Preparing database..."
bundle exec rails db:prepare

# Seed the database if it's empty
echo "Checking if database needs seeding..."
if bundle exec rails runner "exit User.count > 0 ? 0 : 1"; then
  echo "Database already has data, skipping seed"
else
  echo "Seeding database with initial data..."
  bundle exec rails db:seed
fi

echo "Post-deployment setup completed!"
