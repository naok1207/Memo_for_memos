class Searches::Contents::MemosController < Searches::ContentsController
  # 全メモからの検索
  def show
    @memos = @search_content.whole_search.title_asc
  end
end
