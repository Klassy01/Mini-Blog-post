class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Validations
  validates :message, presence: true
  validates :notification_type, presence: true, inclusion: { in: %w[post_published comment_added] }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :unread, -> { where(read: false) }
  scope :by_type, ->(type) { where(notification_type: type) }
end
