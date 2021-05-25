class Users::TagsController < ApplicationController
  def index
    @tags = current_user.tags
  end

  def show
    @tag = Tag.find_by(name: params[:name])
    # @memos = @tag.memos.where(user: current_user)
    @memos = current_user.memos
  end
end