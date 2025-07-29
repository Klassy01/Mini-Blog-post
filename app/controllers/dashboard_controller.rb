class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.includes(:comments).recent.page(params[:page]).per(10)
    @published_posts = current_user.posts.published.count
    @draft_posts = current_user.posts.draft.count
    @total_comments = current_user.comments.count
    @recent_notifications = current_user.notifications.unread.recent.limit(5)
  end
end
