class MemosController < ApplicationController
  before_action :require_login
  layout 'layouts/searches', only: :show

  def index
    @memos = current_user.memos.title_asc
    add_category_name
  end

  def show
    @memo = Memo.find(params[:id])
    impressionist(@memo, nil, unique: [:session_hash])
  end
end
