class ApplicationController < ActionController::Base
  include Calender

  def not_authenticated
    redirect_to login_path
  end

  def already_logged_in
    redirect_to categories_path if logged_in?
  end
end
