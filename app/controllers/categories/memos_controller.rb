class Categories::MemosController < ApplicationController
  def show
    @category = current_user.categories.find_by!(name: params[:category_name])
    @memo = @category.memos.find(params[:id])
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
    @tag_list = @memo.tags.pluck(:name).join(' ')
  end

  def update
    @category = current_user.categories.find_by!(name: params[:category_name])
    @memo = @category.memos.find(params[:id])
    @memo.update(memo_params)
    tag_list = params[:memo][:tags_ids].split
    @memo.save_tags(tag_list)
  end

  def destroy
    @memo = current_user.memos.find(params[:id])
    @memo.destroy!
    redirect_to @memo.categoy
  end

  private
  def memo_params
    params.require(:memo).permit(:title, :body).merge(user_id: current_user.id)
  end
end
