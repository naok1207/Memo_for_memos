class CategoriesController < ApplicationController
  before_action :require_login
  before_action :generate_calender, only: %i[ index show update ]

  def index
    @categories = current_user.categories.main.name_asc
  end

  def show
    @category = current_user.categories.find_by!(name: params[:name])
    @categories = @category.children
    @memos = @category.memos.title_asc
  rescue
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
    if category.save
      @categories = if category_params[:parent_id].present?
                      parent = current_user.categories.find(category_params[:parent_id])
                      parent.children.order(name: :asc)
                    else
                      current_user.categories.where(parent_id: nil).name_asc
                    end
    end
  end

  def edit
    @category = current_user.categories.find_by!(name: params[:name])
  end

  def update
    @category = current_user.categories.find_by!(name: params[:name])
    if @category.update(category_params)
      redirect_to @category
    end
  end

  def destroy
    @category = current_user.categories.find_by!(name: params[:name])
    @category.children_destroy_all
    @category.memos.destroy_all
    @category.destroy!
    redirect_to @category.parent.present? ? @category.parent : categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
