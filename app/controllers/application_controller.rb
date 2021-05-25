class ApplicationController < ActionController::Base
  include Calender

  def not_authenticated
    redirect_to login_path
  end
end
