class ApplicationController < ActionController::Base
  before_action :except_admin

  include Calender

  def not_authenticated
    redirect_to login_path
  end

  def already_logged_in
    redirect_to categories_path if logged_in?
  end

  def set_search_content_form
    @search_content = SearchContent.new
  end

  def add_category_name
    @user = current_user if @user.blank?
    categories = @user.categories.pluck(:id, :name)
    @memos = @memos.each { |memo| memo.category_name = categories.find { |category| category[0] == memo.category_id }[1] }
  end

  def except_admin
    return if current_user.blank?
    redirect_to admin_path if current_user.admin?
  end
end
