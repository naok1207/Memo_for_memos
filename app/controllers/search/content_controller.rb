class Search::ContentController < ApplicationController
  before_action :set_search_content

  private
  def set_search_content
    @search_content = SearchContent.new(search_content_params)
  end

  def search_content_params
    params.require(:search_content).permit(:key_word)
  end
end
