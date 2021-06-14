class ContentSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :key_word, :string

  # その他に基づくメモを検索する
  def user_memo_search(user)
    user.memos.multiple_search(:title_or_body_cont, key_word)
  end

  # 公開されているメモ全体を検索する
  # 公開設定による修正が必要
  def whole_search
    Memos.multiple_search(:title_or_body_cont, key_word)
  end

  # ログインユーザに対するメモを検索する
  # 引数が入っている場合はcategoryに含まれるメモから検索
  def own_memo_search(category = nil)
    search_query = user_memo_search(current_user)
    if category.present?
      category_ids = get_category_ids(category)
      current_user.memos.where(category_id: category_ids)
      search_query.where(category_id: category_ids)
    end
  end

  # 自身のカテゴリを検索する
def own_category_search(category = nil)
    search_query = current_user.categoires.multiple_search(:name)
    if category.present?
      category_ids = get_category_ids(category)
      search_query.where(id: category_ids)
    end
  end

  # 関連するカテゴリのidを全て取得する
  def get_category_ids(category)
    current_user.categories.where("under_category_ids LIKE ?", "%/#{category.id}/%").pluck(:id).push(category.id)
  end
end
