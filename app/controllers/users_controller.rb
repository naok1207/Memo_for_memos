class UsersController < ApplicationController
  before_action :require_login, only: %i[ edit update destroy ]
  before_action :generate_calender, only: :show
  before_action :already_logged_in, only: :new
  before_action :set_search_content_form, only: :show
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
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_settings_profile_path
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy!
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :introduction)
  end
end
