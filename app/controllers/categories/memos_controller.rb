class Categories::MemosController < ApplicationController
  before_action :require_login
  before_action :generate_calender, only: :show

  def show
    @category = current_user.categories.find_by!(name: params[:category_name])
    @memo = @category.memos.find(params[:id])
    @tags = @memo.tags
  end

  def new
    @category = current_user.categories.find_by!(name: params[:category_name])
    @memo = @category.memos.new
  end

  def create
    @category = current_user.categories.find_by!(name: params[:category_name])
    @memo = @category.memos.new(memo_params)
    if @memo.save
      @memos = @category.memos.title_asc
    else
      return
    end
  end

  def edit
    @category = current_user.categories.find_by!(name: params[:category_name])
    @memo = @category.memos.find(params[:id])
    @tag_list = @memo.tags
  end

  def update
    @category = current_user.categories.find_by!(name: params[:category_name])
    @memo = @category.memos.find(params[:id])
    @memo.update(memo_params)
    @memo.save_tags(params[:tags_ids].split(',') ) if params[:tags_ids].present?
    @tags = @memo.tags
  end

  def destroy
    @memo = current_user.memos.find(params[:id])
    @memo.destroy!
    redirect_to @memo.categoy
  end

  private
  def memo_params
    params.require(:memo).permit(:title, :body, :status, :public_status).merge(user_id: current_user.id)
  end
end
