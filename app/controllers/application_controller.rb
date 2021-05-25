class ApplicationController < ActionController::Base
  include Calender
  # before_action :generate_calender

  def not_authenticated
    redirect_to login_path
  end
end
