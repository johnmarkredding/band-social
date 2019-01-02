class UsersController < ApplicationController
  before_action :set_requested_user, only: [:show, :edit, :update, :destroy]
  before_action :require_auth, only: [:edit, :update, :destroy]
  before_action :require_logged_in, only: [:show]

  def show
    @bands = (@requested_user.bands + @requested_user.managed_bands).uniq
    @posts = @requested_user.posts
  end

  def new
    @requested_user = User.new
  end

  def index
    unless !!@logged_in_user
      reject_auth
    end
    @users = User.all
  end

  def create
    @new_user = User.create(user_params)
    if User.exists?(@new_user.id)
      login(@new_user)
      redirect_to user_path(@new_user)
    else
      flash.now[:errors] = @new_user.errors.full_messages
      render :new
    end
  end

  def edit
    @roles = ["user","admin"]
  end

  def update
    if @requested_user.update(user_params)
      redirect_to user_path(@requested_user)
    else
      flash.now[:errors] = @requested_user.errors.full_messages
      render :edit
    end
  end

  def destroy
    @requested_user.destroy
    flash[:success] = "Destroyed"
    reset_session
    redirect_to home_path
  end

  private

  def set_requested_user
    if !!params[:id] && User.exists?(params[:id])
      @requested_user = User.find(params[:id])
    else
      add_error_message("Invalid User")
      redirect_to users_path
    end
  end

  def user_params
    if !!@logged_in_user && @logged_in_user.admin?
      params.require(:user).permit(:username, :name, :password, :role)
    else
      params.require(:user).permit(:username, :name, :password)
    end
  end

  def require_auth
    unless !!@logged_in_user && (@requested_user == @logged_in_user || @logged_in_user.admin?)
      reject_auth
    end
  end
  def require_logged_in
    unless !!@logged_in_user
      reject_auth
    end
  end

  def require_admin_auth
    unless @logged_in_user.admin?
      
      reject_auth
    end
  end
end
