class PostsController < ApplicationController
  before_action :set_requested_user, only: [:index, :new]
  before_action :require_logged_in, only: [:new, :create]


  def index
    @posts = User.find(params[:user_id]).posts
  end
  def new
  end
  def create
    if !!@logged_in_user
      post = Post.new(post_params)
      post.user_id = @logged_in_user.id
      post.save
    else
      add_error_message("Not Authorized!")
    end
    redirect_to home_path
  end

  private

  def set_requested_user
    if !!params[:user_id] && User.exists?(params[:user_id])
      @requested_user = User.find(params[:user_id])
    else
      add_error_message("Invalid User")
      redirect_to users_path
    end
  end

  def post_params
    params.permit(:body, :user_id)
  end
end
