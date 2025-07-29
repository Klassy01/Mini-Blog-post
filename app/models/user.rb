class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }

  # Ransack allowlist
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "id_value", "updated_at", "username"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["posts", "comments", "notifications"]
  end

  # Virtual attribute for display name
  def display_name
    username.presence || email.split('@').first
  end

  # Check if user is admin
  def admin?
    email == 'admin@miniblog.com'
  end
end
