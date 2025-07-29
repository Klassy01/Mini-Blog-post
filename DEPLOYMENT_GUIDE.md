# Mini Blog Deployment Guide for Render

This guide will help you deploy the Mini Blog application to Render platform.

## Prerequisites

1. A GitHub account with your code pushed to a repository
2. A Render account (sign up at [render.com](https://render.com))
3. Your Rails application ready for production

## Step 1: Prepare Your Application

### 1.1 Ensure all files are properly configured

Your application should have:
- ✅ `render.yaml` - Configuration file for Render
- ✅ `bin/render-build.sh` - Build script
- ✅ `config/database.yml` - Database configuration with PostgreSQL for production
- ✅ `config/master.key` - Rails master key for encrypted credentials

### 1.2 Environment Variables Required

The following environment variables will be automatically set by Render:
- `DATABASE_URL` - PostgreSQL connection string (auto-generated)
- `RAILS_MASTER_KEY` - Your Rails master key: `e2ecae55a48739b8e7cf506266c9846b`
- `RAILS_ENV` - Set to `production`
- `RAILS_SERVE_STATIC_FILES` - Set to `true`
- `RAILS_LOG_TO_STDOUT` - Set to `true`

## Step 2: Deploy to Render

### Option A: Blueprint Deployment (Recommended)

1. **Push your code to GitHub**
   ```bash
   git add .
   git commit -m "Ready for Render deployment"
   git push origin main
   ```

2. **Deploy using Render Blueprint**
   - Go to [render.com](https://render.com) and sign in
   - Click "New +" → "Blueprint"
   - Connect your GitHub repository
   - Render will automatically detect the `render.yaml` file
   - Set the `RAILS_MASTER_KEY` environment variable to: `e2ecae55a48739b8e7cf506266c9846b`
   - Click "Apply" to start deployment

### Option B: Manual Deployment

1. **Create PostgreSQL Database**
   - Go to [render.com](https://render.com)
   - Click "New +" → "PostgreSQL"
   - Name: `miniblog-db`
   - Plan: Free
   - Click "Create Database"

2. **Create Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Configure:
     - **Name**: `miniblog`
     - **Environment**: `Ruby`
     - **Build Command**: `./bin/render-build.sh`
     - **Start Command**: `bundle exec puma -C config/puma.rb`

3. **Set Environment Variables**
   - `DATABASE_URL`: Link to your PostgreSQL database
   - `RAILS_MASTER_KEY`: `e2ecae55a48739b8e7cf506266c9846b`
   - `RAILS_ENV`: `production`
   - `RAILS_SERVE_STATIC_FILES`: `true`
   - `RAILS_LOG_TO_STDOUT`: `true`

## Step 3: Verify Deployment

1. Wait for the build to complete (5-10 minutes)
2. Check the build logs for any errors
3. Once deployed, your app will be available at: `https://miniblog.onrender.com`

## Step 4: Test Your Application

Visit your deployed application and test:
- User registration and login
- Creating and viewing blog posts
- Commenting functionality
- Admin panel (login with admin@miniblog.com / password123)

## Troubleshooting

### Common Issues:

1. **Build Fails with Rails Binstub Error**
   - The Rails binstub needs to be regenerated
   - Run: `bundle config --delete bin && rails app:update:bin`
   - Commit the updated `bin/rails` file

2. **PostgreSQL Connection Error During Build**
   - Database is not available during build phase on Render
   - Build script now handles this gracefully
   - Database operations moved to startup command

3. **Database Connection Issues**
   - Ensure `DATABASE_URL` is properly linked
   - Check that PostgreSQL database is running
   - Verify the database service is created and connected

4. **Asset Loading Issues**
   - Verify `RAILS_SERVE_STATIC_FILES=true` is set
   - Check asset precompilation in build logs
   - Ensure assets are properly compiled during build

5. **Master Key Issues**
   - Ensure `RAILS_MASTER_KEY` is set correctly
   - Check that the key matches your `config/master.key` file
   - Key should be: `e2ecae55a48739b8e7cf506266c9846b`

6. **Application Not Starting**
   - Check the startup command includes `rails db:prepare`
   - Verify all environment variables are set
   - Check runtime logs for specific errors

## Test Credentials

After deployment, you can test with these accounts:

### Admin User
- **Email**: `admin@miniblog.com`
- **Password**: `password123`

### Regular Users
- **Email**: `john@example.com`
- **Password**: `password123`
- **Email**: `jane@example.com`
- **Password**: `password123`

## Support

If you encounter issues:
1. Check Render's build and runtime logs
2. Verify all environment variables are set correctly
3. Ensure your database is properly connected
4. Check that your `render.yaml` configuration matches the requirements
