class CategoriesController < ApplicationController
  before_action :require_login
  before_action :generate_calender, only: %i[index show update]
  before_action :set_search_content_form, only: %i[index show]
  before_action :set_category, only: %i[show edit update destroy]

  def index
    if params[:keyword].present?
      @keyword = params[:keyword]
      search_content = SearchContent.new(key_word: @keyword)
      @categories = search_content.own_category_search(current_user, nil)
      @memos = search_content.own_memo_search(current_user, nil)
    else
      @categories = current_user.categories.main.name_asc
    end
  end

  def show
    if params[:keyword].present?
      @keyword = params[:keyword]
      search_content = SearchContent.new(key_word: @keyword)
      @categories = search_content.own_category_search(current_user, @category)
      @memos = search_content.own_memo_search(current_user, @category)
    else
      @categories = @category.children
      @memos = @category.memos.title_asc
    end
    add_category_name
  end

  def new
    @category = if params[:format].present?
                  @parent = current_user.categories.find_by!(name: params[:format])
                  @parent.children.new
                else
                  current_user.categories.new
                end
  end

  def create
    category = current_user.categories.new(category_params)
    return unless category.save

    parent_id = category_params[:parent_id]
    @categories = if parent_id.present?
                    current_user.categories.find(parent_id).children
                  else
                    current_user.categories.where(parent_id: nil)
                  end
  end

  def edit; end

  def update
    redirect_to @category if @category.update(category_params)
  end

  def destroy
    @category.children_destroy_all
    @category.memos.destroy_all
    @category.destroy!
    redirect_to @category.parent.presence || categories_path
  end

  private

  def set_category
    @category = current_user.categories.find_by!(name: params[:name])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
