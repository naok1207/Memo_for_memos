class MemosController < ApplicationController
  def index
    @memos = current_user.memos.title_asc
  end
end
