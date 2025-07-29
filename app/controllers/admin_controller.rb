class AdminController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
    @total_users = User.count
    @total_posts = Post.count
    @total_comments = Comment.count
    @published_posts = Post.published.count
    @draft_posts = Post.draft.count
  end

  def users
    @users = User.includes(:posts, :comments).page(params[:page]).per(20)
  end

  def posts
    @posts = Post.includes(:user, :comments).page(params[:page]).per(20)
  end

  def comments
    @comments = Comment.includes(:user, :post).page(params[:page]).per(20)
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied. Admin only.'
    end
  end
end
