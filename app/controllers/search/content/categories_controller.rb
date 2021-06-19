class Search::Content::CategoriesController < Search::ContentController
  # カテゴリに属するメモの検索
  def show
    category = params[:category_name].present? ? current_user.categories.find_by!(name: [:category_name]) : nil
    @categories = @search_content.own_category_search(current_user, category)
    @memos = @search_content.own_memo_search(current_user, category)
  end
end
