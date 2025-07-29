# Create admin user
admin = User.create!(
  email: 'admin@miniblog.com',
  username: 'admin',
  password: 'password123',
  password_confirmation: 'password123'
)

puts "Created admin user: #{admin.email}"

# Create regular users
user1 = User.create!(
  email: 'john@example.com',
  username: 'john_doe',
  password: 'password123',
  password_confirmation: 'password123'
)

user2 = User.create!(
  email: 'jane@example.com',
  username: 'jane_smith',
  password: 'password123',
  password_confirmation: 'password123'
)

puts "Created regular users: #{user1.email}, #{user2.email}"

# Create sample posts
post1 = Post.create!(
  title: 'Welcome to MiniBlog',
  body: 'This is the first post on our new blogging platform. We are excited to share our thoughts and ideas with the world. This platform is built with Ruby on Rails, Devise for authentication, and PostgreSQL for the database. We hope you enjoy reading our posts!',
  status: 'published',
  user: admin
)

post2 = Post.create!(
  title: 'Getting Started with Rails',
  body: 'Ruby on Rails is a powerful web framework that makes it easy to build web applications. In this post, we will explore the basics of Rails and how to get started with your first application. Rails follows the MVC (Model-View-Controller) pattern and provides many conventions that help developers build applications quickly.',
  status: 'published',
  user: user1
)

post3 = Post.create!(
  title: 'The Power of PostgreSQL',
  body: 'PostgreSQL is a powerful, open-source relational database system. It offers advanced features like JSON support, full-text search, and excellent performance. In this post, we will discuss why PostgreSQL is a great choice for web applications and how to use it effectively with Rails.',
  status: 'published',
  user: user2
)

post4 = Post.create!(
  title: 'Draft: Advanced Rails Techniques',
  body: 'This is a draft post about advanced Rails techniques. We will cover topics like background jobs, caching, and performance optimization. Stay tuned for the final version!',
  status: 'draft',
  user: user1
)

puts "Created sample posts"

# Create sample comments
Comment.create!(
  content: 'Great introduction! Looking forward to more posts.',
  user: user1,
  post: post1
)

Comment.create!(
  content: 'Thanks for sharing this valuable information.',
  user: user2,
  post: post1
)

Comment.create!(
  content: 'Rails is indeed a fantastic framework. Great explanation!',
  user: admin,
  post: post2
)

Comment.create!(
  content: 'PostgreSQL is my favorite database. Excellent choice!',
  user: user1,
  post: post3
)

puts "Created sample comments"

puts "Seed data created successfully!"
puts "Admin credentials: admin@miniblog.com / password123"
puts "User credentials: john@example.com / password123"
puts "User credentials: jane@example.com / password123"
