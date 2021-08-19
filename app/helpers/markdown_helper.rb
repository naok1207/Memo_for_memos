module MarkdownHelper
  def markdown(content)
    return '' if content.blank?

    options ||= {
      filter_html: true,
      autolink: true,
      space_after_headers: true,
      fenced_code_blocks: true,
      underline: true,
      highlight: true,
      footnotes: true,
      tables: true,
      hard_wrap: true,
      xhtml: true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      strikethrough: true
    }
    markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(content).html_safe
  end
end
