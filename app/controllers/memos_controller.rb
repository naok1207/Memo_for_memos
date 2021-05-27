class MemosController < ApplicationController
  before_action :require_login

  def index
    @memos = current_user.memos.title_asc
  end
end
