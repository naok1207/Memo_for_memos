class SearchesController < ApplicationController
  before_action :set_search_content_form, only: :show

  def show
    return if params[:keyword].blank?

    @keyword = params[:keyword]
    search_content = SearchContent.new(key_word: @keyword)
    @memos = search_content.whole_search.title_asc
  end
end
