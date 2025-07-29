class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Validations
  validates :content, presence: true, length: { minimum: 2, maximum: 1000 }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }

  # Ransack allowlist
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "id_value", "post_id", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "post"]
  end

  # Get user display name
  def user_display_name
    user.display_name
  end
end
