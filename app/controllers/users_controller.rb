class UsersController < ApplicationController
  before_action :require_login, only: :destroy
  before_action :generate_calender, only: :show
  before_action :already_logged_in, only: :new
  before_action :set_search_content_form, only: :show
  before_action :set_user, only: :show
  layout 'layouts/basic_auth', only: %i[new create edit]

  def show
    @memos =
      if params[:keyword].present?
        @keyword = params[:keyword]
        search_content = SearchContent.new(key_word: @keyword)
        search_content.user_memo_search(@user).title_asc
      elsif @user == current_user
        @user.memos.order(updated_at: :asc)
      else
        @user.memos.complete.whole_release.order(updated_at: :asc)
      end
    add_category_name
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

  def destroy
    @user = current_user
    @user.destroy!
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :introduction)
  end
end
