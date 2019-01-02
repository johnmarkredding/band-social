class PostsController < ApplicationController
  def index
    @posts = User.find(params[:user_id]).posts
  end
  def new
    unless !!@logged_in_user
      add_error_message("Must be logged in!")
      redirect_to home_path
    end
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

  def post_params
    params.permit(:body, :user_id)
  end
end
