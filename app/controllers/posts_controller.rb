class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @q = Post.published.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user, :comments).recent.page(params[:page]).per(10)
    
    # Apply filters
    if params[:filter] == 'my_posts' && user_signed_in?
      @posts = @posts.by_user(current_user)
    end
    
    # Apply date range filter
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @posts = @posts.date_range(start_date, end_date)
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).recent
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def authorize_user!
    unless @post.user == current_user
      redirect_to @post, alert: 'You are not authorized to perform this action.'
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :status)
  end
end
