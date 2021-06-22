class SearchContent
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :key_word, :string

  # その他に基づくメモを検索する
  def user_memo_search(user)
    user.memos.multiple_search(:title_or_body_cont, key_word).complete
  end

  # 公開されているメモ全体を検索する
  # 公開設定による修正が必要
  def whole_search
    Memo.multiple_search(:title_or_body_cont, key_word).complete
  end

  # ログインユーザに対するメモを検索する
  # 引数が入っている場合はcategoryに含まれるメモから検索
  def own_memo_search(current_user, category = nil)
    search_query = user_memo_search(current_user)
    if category.present?
      category_ids = get_category_ids(category)
      current_user.memos.where(category_id: category_ids)
      return search_query.where(category_id: category_ids)
    end
    return search_query
  end

  # 自身のカテゴリを検索する
  def own_category_search(current_user, category = nil)
    search_query = current_user.categories.multiple_search(:name_cont, key_word)
    if category.present?
      category_ids = get_category_ids(category)
      return search_query.where(id: category_ids)
    end
    return search_query
  end

  # 関連するカテゴリのidを全て取得する
  def get_category_ids(category)
    Category.where("under_category_ids LIKE ?", "%/#{category.id}/%").pluck(:id).push(category.id)
  end
end
