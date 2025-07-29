# MiniBlog - A Ruby on Rails Blogging Platform

A feature-rich mini blogging platform built with Ruby on Rails, featuring user authentication, post management, comments, search functionality, and more.

## 🚀 Features

### Core Features
- **User Authentication** - Sign up, sign in, profile management with Devise
- **Post Management** - Create, edit, delete posts with draft/published status
- **Comment System** - Add comments to posts (authenticated users only)
- **Search & Filtering** - Search posts by title/content, filter by date range and user
- **User Dashboard** - Personal dashboard with post statistics and management
- **Slug-based URLs** - SEO-friendly URLs using Friendly ID

### Advanced Features (Bonus)
- **Background Jobs** - DelayedJob for post publication notifications
- **API Endpoints** - JSON API with JWT authentication
- **Admin Panel** - Content management for administrators
- **Responsive Design** - Bootstrap 5 for mobile-friendly interface

## 🛠 Tech Stack

- **Backend**: Ruby on Rails 7.1.5
- **Database**: PostgreSQL (production), SQLite3 (development)
- **Authentication**: Devise
- **Search**: Ransack
- **Pagination**: Kaminari
- **Background Jobs**: DelayedJob
- **Frontend**: Bootstrap 5, Font Awesome
- **API**: JWT for token-based authentication

## 📋 Prerequisites

- Ruby 3.0.2 or higher
- Rails 7.1.5
- PostgreSQL (for production)
- Node.js (for asset compilation)

## 🚀 Quick Start

### Local Development

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd mini_blog
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server**
   ```bash
   rails server
   ```

5. **Start background jobs (optional)**
   ```bash
   bin/delayed_job start
   ```

6. **Visit the application**
   - Open your browser and go to `http://localhost:3000`

## 🌐 Deployment on Render

### Option 1: Deploy with Render Blueprint (Recommended)

1. **Push your code to GitHub**
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

2. **Deploy on Render**
   - Go to [render.com](https://render.com)
   - Sign up/Login with your GitHub account
   - Click "New +" and select "Blueprint"
   - Connect your GitHub repository
   - Render will automatically detect the `render.yaml` file
   - Click "Apply" to deploy

### Option 2: Manual Deployment

1. **Create a new Web Service**
   - Go to [render.com](https://render.com)
   - Click "New +" and select "Web Service"
   - Connect your GitHub repository

2. **Configure the service**
   - **Name**: `miniblog`
   - **Environment**: `Ruby`
   - **Build Command**: `./bin/render-build.sh`
   - **Start Command**: `bundle exec puma -C config/puma.rb`

3. **Add Environment Variables**
   - `RAILS_ENV`: `production`
   - `RAILS_MASTER_KEY`: (Get from `config/master.key`)
   - `RAILS_SERVE_STATIC_FILES`: `true`
   - `RAILS_LOG_TO_STDOUT`: `true`

4. **Create PostgreSQL Database**
   - Click "New +" and select "PostgreSQL"
   - Name: `miniblog-db`
   - Plan: Free

5. **Link Database to Web Service**
   - In your web service settings, add the database URL as an environment variable
   - `DATABASE_URL`: (Auto-populated from the database)

## 🔑 Test Credentials

### Admin User
- **Email**: `admin@miniblog.com`
- **Password**: `password123`

### Regular Users
- **Email**: `john@example.com`
- **Password**: `password123`
- **Email**: `jane@example.com`
- **Password**: `password123`

## 📁 Project Structure

```
mini_blog/
├── app/
│   ├── controllers/          # Application controllers
│   ├── models/              # ActiveRecord models
│   ├── views/               # ERB templates
│   └── jobs/                # Background jobs
├── config/
│   ├── routes.rb            # Application routes
│   ├── database.yml         # Database configuration
│   └── environments/        # Environment-specific configs
├── db/
│   ├── migrate/             # Database migrations
│   └── seeds.rb             # Seed data
├── bin/
│   └── render-build.sh      # Render deployment script
├── render.yaml              # Render blueprint configuration
└── README.md               # This file
```

## 🎯 API Endpoints

### Authentication
All API requests require a JWT token in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

### Available Endpoints
- `GET /api/posts` - List all published posts
- `GET /api/posts/:id` - Get a specific published post

## 🔧 Configuration

### Environment Variables
- `RAILS_ENV` - Application environment
- `DATABASE_URL` - Database connection string
- `RAILS_MASTER_KEY` - Rails master key for credentials
- `RAILS_SERVE_STATIC_FILES` - Serve static files in production
- `RAILS_LOG_TO_STDOUT` - Log to stdout in production

### Database Configuration
- **Development**: SQLite3
- **Production**: PostgreSQL (configured via DATABASE_URL)

## 🚀 Features in Detail

### User Authentication
- User registration with username and email
- Login/logout functionality
- Password reset capability
- Profile editing
- Automatic redirect to dashboard after login

### Post Management
- Create posts with title, body, and status (draft/published)
- Edit and delete own posts
- Slug-based URLs for SEO
- Post preview functionality
- Comment count display

### Search & Filtering
- Full-text search in post titles and content
- Filter by publication status
- Filter by date range
- Filter by user (for authenticated users)
- Pagination support

### Dashboard
- Personal post statistics
- Recent notifications
- Quick actions for post management
- Post status indicators

### Admin Panel
- View all users and their statistics
- Manage all posts and comments
- Delete inappropriate content
- System-wide statistics

### Background Jobs
- Automatic notification when posts are published
- Email simulation (logs to console)
- Notification storage in database

## 🔒 Security Considerations

- CSRF protection enabled
- SQL injection protection via ActiveRecord
- XSS protection via Rails
- Secure password hashing with Devise
- JWT token-based API authentication
- Input validation and sanitization

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Ensure PostgreSQL is running
   - Check DATABASE_URL environment variable
   - Run `rails db:migrate` to create tables

2. **Asset Compilation Error**
   - Run `rails assets:precompile`
   - Check for missing dependencies

3. **Background Jobs Not Working**
   - Ensure DelayedJob worker is running
   - Check job queue in database

4. **API Authentication Error**
   - Verify JWT token is valid
   - Check Authorization header format

### Development Commands

```bash
# Reset database
rails db:drop db:create db:migrate db:seed

# Check routes
rails routes

# Console access
rails console

# Database console
rails dbconsole

# Run tests
rails test
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Ruby on Rails team for the amazing framework
- Devise team for authentication
- Bootstrap team for the UI framework
- Render team for the deployment platform

---

**Happy Blogging!** 🚀
