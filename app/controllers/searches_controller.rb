class SearchesController < ApplicationController
  before_action :set_search_content_form, only: :show

  def show
    @memos =
    if params[:keyword].present?
      @keyword = params[:keyword]
      search_content = SearchContent.new(key_word: @keyword)
      search_content.whole_search.title_asc
    end
  end
end
