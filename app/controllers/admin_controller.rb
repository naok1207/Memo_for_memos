class AdminController < ActionController::Base
  before_action :require_login
  before_action :require_admin

  def show; end

  private

  def require_admin
    raise unless current_user.admin?
  end
end
