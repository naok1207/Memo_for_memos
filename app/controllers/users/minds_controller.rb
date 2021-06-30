class Users::MindsController < ApplicationController
  layout 'layouts/minds'

  def show
    @user = User.find_by!(username: params[:user_username])
    @categories = @user.categories.pluck(:id, :name, :parent_id).map{ |id, name, parent_id| { id: id, name: name, parent_id: parent_id }}
    @memos = @user.memos.pluck(:id, :title, :category_id).map{ |id, title, category_id| { id: id, title: title, category_id: category_id }}
  end
end
