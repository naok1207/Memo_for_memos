class Search::Content::UsersController < Search::ContentController
  # 他のユーザの検索
  def show
    user = User.find_by(username: params[:username])
    @memos = @search_content.user_memo_search(user).title_asc
  end
end
