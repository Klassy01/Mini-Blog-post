class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Friendly ID for slugs
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Validations
  validates :title, presence: true, length: { minimum: 5, maximum: 200 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :status, presence: true, inclusion: { in: %w[draft published] }

  # Scopes
  scope :published, -> { where(status: 'published') }
  scope :draft, -> { where(status: 'draft') }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_user, ->(user) { where(user: user) }

  # Callbacks
  after_update :notify_published, if: :saved_change_to_status?

  # Ransack allowlist
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "id_value", "slug", "status", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "comments", "notifications"]
  end

  # Search functionality
  def self.search(query)
    where("title ILIKE ? OR body ILIKE ?", "%#{query}%", "%#{query}%")
  end

  # Filter by date range
  def self.date_range(start_date, end_date)
    where(created_at: start_date.beginning_of_day..end_date.end_of_day)
  end

  # Check if post is published
  def published?
    status == 'published'
  end

  # Check if post is draft
  def draft?
    status == 'draft'
  end

  # Get comment count
  def comment_count
    comments.count
  end

  # Preview of body content
  def preview
    body.truncate(200)
  end

  private

  def notify_published
    if published? && status_previously_changed?
      NotificationJob.perform_later(self)
    end
  end
end
