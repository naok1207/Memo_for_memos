class Searches::ContentsController < ApplicationController
  before_action :set_search_content

  private

  def set_search_content
    @search_content = SearchContent.new(search_content_params)
    @keyword = search_content_params[:key_word]
  end

  def search_content_params
    params.require(:search_content).permit(:key_word)
  end
end
