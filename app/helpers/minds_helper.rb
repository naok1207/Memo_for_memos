module MindsHelper
  def generate_minds(parent_id = nil)
    html = ''
    @categories.filter { |category| category[:parent_id] == parent_id }.each do |parent|
      html += "<div class='category-group'>"
      html += "<div class='neo mind-card category'>#{parent[:name]}</div><div class='children'>"
      html += generate_minds(parent[:id]) if @categories.any? { |category| category[:parent_id] == parent[:id] }
      html += "<div class='memo-group'>"
      @memos.filter { |memo| memo[:category_id] == parent[:id] }.each do |memo|
        html += "<div class='neo mind-card memo'>#{memo[:title]}</div>"
      end
      html += '</div>'
      html += '</div>'
      html += '</div>'
    end
    html.html_safe
  end
end
