class Search::Content::MemosController < Search::ContentController
  # 全メモからの検索
  def show
    @search_content.whole_search
  end
end
