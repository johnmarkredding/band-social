class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if !!@user && @user.authenticate(params[:password])
      login(@user)
      redirect_to home_path
    elsif !!@user
      flash.now[:errors] ||= []
      flash.now[:errors] << "Wrong password."
      render :new
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << "Invalid username."
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to home_path
  end
end
