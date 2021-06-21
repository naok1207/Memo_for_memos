class MemosController < ApplicationController
  before_action :require_login
  layout 'layouts/searches', only: :show

  def index
    @memos = current_user.memos.title_asc
  end

  def show
    @memo = Memo.find(params[:id])
  end
end
