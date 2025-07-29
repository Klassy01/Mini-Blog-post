# MiniBlog - A Ruby on Rails Blogging Platform

A comprehensive mini blogging platform built with Ruby on Rails, demonstrating advanced concepts including legacy Rails version compatibility, Devise authentication, complex associations, PostgreSQL integration, and sophisticated controller logic.

## 🚀 Features Implemented

### ✅ Core Requirements

#### 🔐 **Authentication (Devise)**
- Complete Devise implementation for User model
- User registration, sign in, profile editing, and password changes
- After login redirect to user dashboard
- Authentication filters for protected actions

#### ✍️ **Posts System**
- **Access Control**: Only logged-in users can create, edit, or delete their own posts
- **Post Attributes**: title, body, status (draft/published), timestamps
- **Slug URLs**: SEO-friendly URLs using FriendlyId gem (`/posts/my-first-blog` instead of `/posts/1`)
- **Ownership Validation**: Users can only modify their own posts

#### 🧾 **Comments System**
- **Authenticated Comments**: Only logged-in users can comment on posts
- **Public Viewing**: Non-authenticated users can view posts but cannot comment
- **Comment Display**: Shows all comments with username and timestamp
- **Comment Management**: Users can delete their own comments

#### 🔎 **Search & Filtering**
- **Search Bar**: Search posts by title and content using Ransack gem
- **Filter Options**:
  - Show only published posts (default for public)
  - Show only own posts (for logged-in users)
  - Filter by date range (start_date to end_date)
- **Advanced Search**: Case-insensitive full-text search

#### 📋 **User Dashboard**
- **Post Management**: List of user's posts with:
  - Status indicators (published/draft)
  - Number of comments per post
  - Quick actions (edit/delete)
  - Post preview/excerpt
- **Statistics**: Published vs draft post counts
- **Notifications**: Recent activity notifications

### ✅ **Bonus Features Implemented**

#### ⚙️ **Background Jobs**
- **DelayedJob Integration**: Background job processing
- **Publication Notifications**: Triggered when posts are published
- **Notification System**: Database-stored notifications for users
- **Event Logging**: Activity tracking in notifications table

#### 📁 **API Endpoints (JSON)**
- **Endpoints**: `/api/posts` (index) and `/api/posts/:id` (show)
- **Content Filter**: Only published posts accessible via API
- **JWT Authentication**: Token-based authentication for API requests
- **Pagination**: API responses include pagination metadata
- **Structured JSON**: Consistent API response format

#### 📄 **Admin Panel**
- **Access Control**: Hard-coded admin check (admin@miniblog.com)
- **User Management**: View all users, post counts, comment counts
- **Content Moderation**: 
  - View all posts across all users
  - View all comments across all users
  - Delete inappropriate posts and comments
- **Dashboard Statistics**: System-wide metrics

### 🛠 **Technical Implementation**

#### **Legacy Rails Compatibility**
- Rails 7.1.5 with Ruby 3.0.2
- PostgreSQL for production, SQLite3 for development
- Proper gem grouping for different environments

#### **Advanced Associations**
- User has_many posts and comments
- Post belongs_to user, has_many comments
- Polymorphic notification system
- Dependent destroy relationships

#### **Controller Logic**
- Before action filters for authentication and authorization
- Custom authentication methods for API and admin access
- Proper parameter sanitization and strong parameters
- Error handling and user feedback

#### **Database Design**
- SQLite3 for development and test environments
- PostgreSQL for production deployment
- Proper foreign key relationships and constraints
- Database indexes for performance optimization

#### **Security Features**
- CSRF protection
- Strong parameter filtering
- User authorization checks
- Admin role-based access control
- JWT token validation for API access

## 🛠 **Tech Stack**

- **Backend**: Ruby on Rails 7.1.5
- **Ruby Version**: 3.0.2
- **Database**: PostgreSQL (production), SQLite3 (development)
- **Authentication**: Devise
- **Search**: Ransack gem
- **Pagination**: Kaminari gem
- **Background Jobs**: DelayedJob
- **Slugs**: FriendlyId gem
- **Frontend**: Bootstrap 5, ERB templates
- **API**: JWT for token-based authentication

## 📋 **Prerequisites**

- Ruby 3.0.2 or higher
- Rails 7.1.5
- PostgreSQL (for production)
- Node.js (for asset compilation)
- Git for version control

## 🚀 **Setup Instructions**

### **Local Development Setup**

1. **Clone the repository**
   ```bash
   git clone https://github.com/Klassy01/Mini-Blog-post.git
   cd Mini-Blog-post
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Setup database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the Rails server**
   ```bash
   rails server
   ```

5. **Start background jobs (optional)**
   ```bash
   bin/delayed_job start
   ```

6. **Visit the application**
   - Open your browser and go to `http://localhost:3000`

### **Production Deployment on Render**

Follow the detailed deployment guide in [`DEPLOYMENT_GUIDE.md`](./DEPLOYMENT_GUIDE.md)

## 🔑 **Test Credentials**

### **Admin User**
- **Email**: `admin@miniblog.com`
- **Password**: `password123`
- **Access**: Full admin panel access

### **Regular Users**
- **Email**: `john@example.com` / **Password**: `password123`
- **Email**: `jane@example.com` / **Password**: `password123`
- **Access**: Standard user features

## 🧪 **API Testing**

### **Generate JWT Token**
```bash
# In Rails console
user = User.find_by(email: 'john@example.com')
token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base, 'HS256')
```

### **API Endpoints**
```bash
# Get all published posts
curl -H "Authorization: Bearer YOUR_TOKEN" \
     http://localhost:3000/api/posts

# Get specific post
curl -H "Authorization: Bearer YOUR_TOKEN" \
     http://localhost:3000/api/posts/welcome-to-miniblog
```

## 🗂 **Key Files and Structure**

```
app/
├── controllers/
│   ├── application_controller.rb     # Base controller
│   ├── posts_controller.rb          # Post CRUD operations
│   ├── comments_controller.rb       # Comment management
│   ├── dashboard_controller.rb      # User dashboard
│   ├── admin_controller.rb          # Admin panel
│   └── api/
│       └── posts_controller.rb      # API endpoints
├── models/
│   ├── user.rb                      # User model with Devise
│   ├── post.rb                      # Post model with FriendlyId
│   ├── comment.rb                   # Comment model
│   └── notification.rb             # Notification system
├── views/                           # ERB templates
├── jobs/
│   └── notification_job.rb         # Background job
└── assets/                         # Stylesheets and JavaScript

config/
├── routes.rb                       # Application routes
├── database.yml                    # Database configuration
└── environments/                   # Environment-specific configs

db/
├── migrate/                        # Database migrations
└── seeds.rb                       # Sample data
```

## 🔄 **Design Decisions**

### **Authentication Strategy**
- **Devise**: Chosen for mature, battle-tested authentication
- **Admin Check**: Simple email-based admin identification
- **JWT API**: Token-based authentication for stateless API access

### **Database Design**
- **PostgreSQL**: Production database for scalability and features
- **SQLite3**: Development database for simplicity
- **FriendlyId**: SEO-friendly URLs for better user experience

### **Search Implementation**
- **Ransack**: Advanced search with filtering capabilities
- **Full-text Search**: ILIKE queries for case-insensitive search
- **Date Range**: Flexible date filtering with proper timezone handling

### **Background Jobs**
- **DelayedJob**: Simple job queue for notification processing
- **Notification System**: Database-stored notifications for tracking

### **API Design**
- **RESTful**: Standard REST conventions
- **JSON-only**: API endpoints serve only JSON responses
- **Pagination**: Kaminari integration for large datasets

### **Frontend Features**
- **Responsive Design**: Bootstrap 5 for mobile-friendly interface
- **User Experience**: Intuitive navigation and clean design
- **Flash Messages**: User feedback for all actions
- **Pagination**: Smooth navigation through large datasets

## 📊 **Assignment Compliance**

| Requirement | Status | Implementation Details |
|-------------|--------|----------------------|
| **🔐 Devise Authentication** | ✅ Complete | User model with registration, login, profile editing |
| **✍️ Posts CRUD** | ✅ Complete | Full CRUD with owner authorization |
| **🔗 Slug URLs** | ✅ Complete | FriendlyId gem implementation |
| **🧾 Comments System** | ✅ Complete | Authenticated comments with authorization |
| **🔍 Search & Filter** | ✅ Complete | Ransack-powered search with multiple filters |
| **📋 User Dashboard** | ✅ Complete | Post management with statistics |
| **⚙️ Background Jobs** | ✅ Complete | DelayedJob with notification system |
| **📁 JSON API** | ✅ Complete | JWT-authenticated REST API |
| **👨‍💼 Admin Panel** | ✅ Complete | Full content management system |

## 🏗 **Advanced Implementation Notes**

### **Legacy Rails Compatibility**
- Compatible with Rails 7.1.5 and Ruby 3.0.2
- Proper dependency management for production/development
- Database adapter configuration for different environments

### **Complex Associations**
```ruby
# User model relationships
has_many :posts, dependent: :destroy
has_many :comments, dependent: :destroy
has_many :notifications, dependent: :destroy

# Post model with polymorphic notifications
has_many :comments, dependent: :destroy
has_many :notifications, as: :notifiable
```

### **Advanced Controller Logic**
- Multiple before_action filters for security
- Custom authorization methods
- API versioning structure
- Proper error handling and user feedback

### **PostgreSQL Integration**
- Production-ready database configuration
- Proper connection pooling
- SSL mode configuration for security
- Environment-specific database adapters

## 🧪 **Testing**

### **Test Coverage**
- Controller tests for all major actions
- Model tests for validations and associations
- Integration tests for user workflows
- API endpoint testing

### **Running Tests**
```bash
# Run all tests
rails test

# Run specific test file
rails test test/controllers/posts_controller_test.rb

# Run with coverage
rails test:coverage
```

## 🔧 **Development Tools**

### **Debugging**
- Rails console for interactive debugging
- Debug gem for step-through debugging
- Log level configuration per environment

### **Code Quality**
- Strong parameters for security
- Model validations for data integrity
- Consistent error handling patterns

## 📈 **Performance Considerations**

### **Database Optimization**
- Includes for N+1 query prevention
- Proper indexing on foreign keys
- Pagination to limit result sets

### **Caching Strategy**
- Fragment caching ready for implementation
- Database query optimization
- Asset pipeline optimization

## � **Production Readiness**

### **Deployment Features**
- Environment-specific configurations
- Asset precompilation
- Database migration scripts
- Health check endpoints ready

### **Monitoring**
- Rails log configuration
- Error tracking ready
- Performance monitoring hooks

## � **User Experience**

### **Interface Design**
- Bootstrap 5 responsive framework
- Intuitive navigation structure
- Consistent feedback mechanisms
- Mobile-first approach

### **Accessibility**
- Semantic HTML structure
- Proper form labeling
- Keyboard navigation support
- Screen reader friendly elements

---

## 📝 **Quick Feature Checklist**

- [x] **Authentication**: Devise setup with user registration/login
- [x] **Posts**: CRUD operations with draft/published status
- [x] **Comments**: Authenticated commenting system
- [x] **Search**: Full-text search with filtering
- [x] **Dashboard**: User post management interface
- [x] **Admin**: Content management panel
- [x] **API**: JWT-authenticated JSON endpoints
- [x] **Jobs**: Background notification processing
- [x] **Slugs**: SEO-friendly URLs
- [x] **Responsive**: Mobile-friendly design
- [x] **Security**: Authorization and input validation
- [x] **Production**: Render deployment ready

## 🏆 **Assignment Submission Summary**

This Mini Blog application demonstrates advanced Ruby on Rails development skills including:

- **Legacy Rails Version Management**: Rails 7.1.5 with Ruby 3.0.2
- **Devise Integration**: Complete authentication system
- **Complex Associations**: Multi-model relationships with proper dependency management
- **PostgreSQL Skills**: Production database configuration and optimization
- **Advanced Controller Logic**: Authentication, authorization, and API development
- **Background Processing**: Job queuing and notification systems
- **Security Implementation**: CSRF protection, strong parameters, and access control
- **Production Deployment**: Render platform integration with environment management

**Repository**: [https://github.com/Klassy01/Mini-Blog-post](https://github.com/Klassy01/Mini-Blog-post)

**Live Demo**: [Available after Render deployment](https://miniblog.onrender.com)

---

**🎯 Ready for production deployment and demonstration!**
