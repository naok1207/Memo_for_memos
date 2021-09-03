class Searches::Contents::MemosController < Searches::ContentsController
  skip_before_action :except_admin

  # 全メモからの検索
  def show
    @memos = @search_content.whole_search.title_asc
  end
end
