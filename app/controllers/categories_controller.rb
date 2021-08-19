class CategoriesController < ApplicationController
  before_action :require_login
  before_action :generate_calender, only: %i[index show update]
  before_action :set_search_content_form, only: %i[index show]

  def index
    @categories = current_user.categories.main.name_asc
  end

  def show
    @category = current_user.categories.find_by!(name: params[:name])
    @categories = @category.children
    @memos = @category.memos.title_asc
    add_category_name
  rescue StandardError
    redirect_to categories_path, alert: "not found #{params[:name]} category"
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

  def edit
    @category = current_user.categories.find_by!(name: params[:name])
  end

  def update
    @category = current_user.categories.find_by!(name: params[:name])
    redirect_to @category if @category.update(category_params)
  end

  def destroy
    @category = current_user.categories.find_by!(name: params[:name])
    @category.children_destroy_all
    @category.memos.destroy_all
    @category.destroy!
    redirect_to @category.parent.presence || categories_path
  end

  def search
    category = current_user.categories.find_by(name: params[:category_name])
    ContentSearchForm.own_search(params[:key_word], category)
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
