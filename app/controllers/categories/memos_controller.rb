class Categories::MemosController < ApplicationController
  before_action :require_login
  before_action :generate_calender, only: :show
  before_action :set_category, only: %i[show new create edit update]

  def show
    @memo = @category.memos.find(params[:id])
    @tags = @memo.tags
  end

  def new
    @memo = @category.memos.new
  end

  def create
    @memo = @category.memos.new(memo_params)
    @memos = @category.memos.title_asc if @memo.save
  end

  def edit
    @memo = @category.memos.find(params[:id])
    @tag_list = @memo.tags
  end

  def update
    @memo = @category.memos.find(params[:id])
    @memo.update(memo_params)
    @memo.save_tags(params[:tags_ids].split(',')) if params[:tags_ids].present?
    @tags = @memo.tags
  end

  def destroy
    @memo = current_user.memos.find(params[:id])
    @memo.destroy!
    redirect_to @memo.categoy
  end

  private

  def set_category
    @category = current_user.categories.find_by!(name: params[:category_name])
  end

  def memo_params
    params.require(:memo).permit(:title, :body, :status, :public_status).merge(user_id: current_user.id)
  end
end
