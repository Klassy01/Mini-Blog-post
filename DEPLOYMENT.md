# 🚀 Deployment Guide - MiniBlog on Render

This guide will walk you through deploying your MiniBlog application to Render platform.

## 📋 Prerequisites

1. **GitHub Account** - Your code must be in a GitHub repository
2. **Render Account** - Sign up at [render.com](https://render.com)
3. **Rails Master Key** - You'll need your Rails master key for production

## 🎯 Option 1: Deploy with Render Blueprint (Easiest)

### Step 1: Prepare Your Repository

1. **Ensure your code is pushed to GitHub**
   ```bash
   git add .
   git commit -m "Prepare for Render deployment"
   git push origin main
   ```

2. **Get your Rails master key**
   ```bash
   cat config/master.key
   ```
   Copy this key - you'll need it for the deployment.

### Step 2: Deploy on Render

1. **Go to Render Dashboard**
   - Visit [render.com](https://render.com)
   - Sign in with your GitHub account

2. **Create Blueprint**
   - Click "New +" button
   - Select "Blueprint"
   - Connect your GitHub repository
   - Render will automatically detect the `render.yaml` file

3. **Configure Deployment**
   - **Blueprint Name**: `miniblog-blueprint`
   - **Branch**: `main`
   - Click "Apply" to start deployment

4. **Set Environment Variables**
   - In your web service settings, add:
     - `RAILS_MASTER_KEY`: (paste your master key from step 1)

5. **Wait for Deployment**
   - Render will automatically:
     - Create a PostgreSQL database
     - Build your application
     - Run migrations and seed data
     - Deploy to production

## 🎯 Option 2: Manual Deployment

### Step 1: Create PostgreSQL Database

1. **Create Database**
   - Go to Render Dashboard
   - Click "New +" → "PostgreSQL"
   - **Name**: `miniblog-db`
   - **Database**: `miniblog_production`
   - **User**: `miniblog_user`
   - **Plan**: Free
   - Click "Create Database"

2. **Copy Database URL**
   - Note the "External Database URL" - you'll need this

### Step 2: Create Web Service

1. **Create Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository

2. **Configure Service**
   - **Name**: `miniblog`
   - **Environment**: `Ruby`
   - **Region**: Choose closest to your users
   - **Branch**: `main`
   - **Root Directory**: Leave empty (if app is in root)

3. **Build & Start Commands**
   - **Build Command**: `./bin/render-build.sh`
   - **Start Command**: `bundle exec puma -C config/puma.rb`

### Step 3: Environment Variables

Add these environment variables in your web service settings:

| Variable | Value | Description |
|----------|-------|-------------|
| `RAILS_ENV` | `production` | Rails environment |
| `RAILS_MASTER_KEY` | `your-master-key` | Rails master key |
| `RAILS_SERVE_STATIC_FILES` | `true` | Serve static assets |
| `RAILS_LOG_TO_STDOUT` | `true` | Log to stdout |
| `DATABASE_URL` | `auto-populated` | Database connection |

### Step 4: Deploy

1. **Click "Create Web Service"**
2. **Wait for build to complete**
3. **Your app will be available at**: `https://your-app-name.onrender.com`

## 🔧 Post-Deployment Setup

### 1. Verify Deployment

1. **Check your app URL**
   - Visit your deployed application
   - Test basic functionality

2. **Check logs**
   - Go to your web service in Render
   - Click "Logs" tab
   - Look for any errors

### 2. Test Features

1. **User Registration**
   - Try creating a new account
   - Verify email confirmation works

2. **Post Creation**
   - Create a test post
   - Verify it appears on the site

3. **Admin Panel**
   - Login with admin credentials
   - Test admin functionality

### 3. Custom Domain (Optional)

1. **Add Custom Domain**
   - Go to your web service settings
   - Click "Custom Domains"
   - Add your domain name

2. **Configure DNS**
   - Point your domain to Render's servers
   - Wait for DNS propagation

## 🐛 Troubleshooting

### Common Issues

1. **Build Fails**
   - Check build logs for errors
   - Ensure all gems are in Gemfile
   - Verify Ruby version compatibility

2. **Database Connection Error**
   - Verify DATABASE_URL is set correctly
   - Check database is running
   - Ensure migrations ran successfully

3. **Asset Compilation Error**
   - Check for missing dependencies
   - Verify asset pipeline configuration
   - Look for JavaScript/CSS errors

4. **Application Crashes**
   - Check application logs
   - Verify environment variables
   - Test locally first

### Debug Commands

```bash
# Check Rails logs
rails logs:tail

# Test database connection
rails dbconsole

# Check environment
rails runner "puts Rails.env"

# Verify master key
rails runner "puts Rails.application.credentials.secret_key_base"
```

## 🔒 Security Checklist

- [ ] Rails master key is set
- [ ] Database URL is secure
- [ ] HTTPS is enabled
- [ ] Environment variables are set
- [ ] No sensitive data in logs
- [ ] Admin credentials are secure

## 📊 Monitoring

### Render Dashboard
- **Uptime**: Monitor service availability
- **Logs**: Check for errors and performance
- **Metrics**: CPU, memory, and response times

### Application Monitoring
- **Error Tracking**: Consider adding error tracking (Sentry, Rollbar)
- **Performance**: Monitor response times
- **Database**: Check query performance

## 🔄 Updates and Maintenance

### Deploying Updates

1. **Push changes to GitHub**
   ```bash
   git add .
   git commit -m "Update description"
   git push origin main
   ```

2. **Render auto-deploys**
   - Render automatically detects changes
   - Builds and deploys new version
   - Zero-downtime deployment

### Database Migrations

1. **Create migration**
   ```bash
   rails generate migration AddNewField
   ```

2. **Deploy**
   - Push to GitHub
   - Render runs migrations automatically

### Backup Strategy

1. **Database Backups**
   - Render provides automatic backups
   - Configure backup frequency in database settings

2. **Code Backups**
   - GitHub serves as code backup
   - Consider additional backup solutions

## 💰 Cost Optimization

### Free Tier Limits
- **Web Services**: 750 hours/month
- **Databases**: 90 days free trial
- **Bandwidth**: 100GB/month

### Upgrade Considerations
- **Paid Plans**: Start at $7/month
- **Custom Domains**: Free with paid plans
- **SSL Certificates**: Free with all plans

## 🎉 Success!

Your MiniBlog application is now live on Render! 

**Next Steps:**
1. Share your app URL
2. Monitor performance
3. Gather user feedback
4. Plan future enhancements

---

**Need Help?**
- [Render Documentation](https://render.com/docs)
- [Rails Deployment Guide](https://guides.rubyonrails.org/deployment.html)
- [Render Support](https://render.com/support) 