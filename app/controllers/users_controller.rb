class UsersController < ApplicationController
  layout 'layouts/basic_auth', only: %i[ new edit ]

  def show
    @user = User.find_by!(username: params[:username])
  rescue
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find_by!(username: current_user.username)
  end

  def update
    @user = User.find_by!(username: current_user.username)
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by!(username: current_user.username)
    @user.destroy!
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
