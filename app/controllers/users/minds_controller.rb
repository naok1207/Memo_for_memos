class Users::MindsController < ApplicationController
  layout 'layouts/minds'

  def show
    @user = User.find_by!(username: params[:user_username])
  end
end
