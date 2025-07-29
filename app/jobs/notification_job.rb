class NotificationJob < ApplicationJob
  queue_as :default

  def perform(post)
    # Create notification for the post author
    Notification.create!(
      user: post.user,
      post: post,
      message: "Your post '#{post.title}' has been published!",
      notification_type: 'post_published',
      read: false
    )

    # Simulate sending email notification
    Rails.logger.info "Sending email notification to #{post.user.email} for post: #{post.title}"
    
    # In a real application, you would send an actual email here
    # UserMailer.post_published_notification(post).deliver_now
  end
end
