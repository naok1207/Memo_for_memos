class BookmarksController < ApplicationController
  def show
    @memos = current_user.bookmark_memos
  end

  def create
    @memo = Memo.find(params[:memo_id])
    current_user.add_bookmark(@memo)
  end

  def destroy
    @memo = Memo.find(params[:memo_id])
    current_user.remove_bookmark(@memo)
  end
end
