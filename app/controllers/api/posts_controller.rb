class Api::PostsController < ApplicationController
  before_action :authenticate_api_user!, only: [:show]
  skip_before_action :verify_authenticity_token

  def index
    @posts = Post.published.includes(:user, :comments).recent.page(params[:page]).per(10)
    
    render json: {
      posts: @posts.map { |post| post_json(post) },
      meta: {
        current_page: @posts.current_page,
        total_pages: @posts.total_pages,
        total_count: @posts.total_count
      }
    }
  end

  def show
    @post = Post.published.friendly.find(params[:id])
    render json: post_json(@post, include_comments: true)
  end

  private

  def authenticate_api_user!
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless token
    
    begin
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })
      user_id = decoded_token[0]['user_id']
      @current_user = User.find(user_id)
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  def post_json(post, include_comments: false)
    json = {
      id: post.id,
      title: post.title,
      body: post.body,
      slug: post.slug,
      status: post.status,
      created_at: post.created_at,
      updated_at: post.updated_at,
      user: {
        id: post.user.id,
        username: post.user.username,
        display_name: post.user.display_name
      },
      comment_count: post.comment_count
    }

    if include_comments
      json[:comments] = post.comments.recent.map do |comment|
        {
          id: comment.id,
          content: comment.content,
          created_at: comment.created_at,
          user: {
            id: comment.user.id,
            username: comment.user.username,
            display_name: comment.user.display_name
          }
        }
      end
    end

    json
  end
end
