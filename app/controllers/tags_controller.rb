class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by!(name: params[:name])
    @memos = @tag.memos
    add_category_name
  end
end
