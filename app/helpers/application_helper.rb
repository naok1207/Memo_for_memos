module ApplicationHelper
  def default_meta_tags
		{
			site: 'Memomo',
			title: 'Memomo',
			reverse: true,
			charset: 'utf-8',
			description: 'description',
			keywords: 'keywords',
			canonical: request.original_url,
			separator: '|',
			icon: [
				{ href: image_url('/favicon.ico') },
				{ href: image_url('/icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180'}
			],
			og: default_og,
			twitter: {
				card: 'summary',
				image: ogp_url(:title),
				site:	'@naok1207'
			}
		}
  end

	def default_og
    return unless noindex?
    {
      title: :title,
      description: :description,
      type: 'website',
      url: request.original_url,
      image: ogp_url(:title),
      site_name: 'Memomo',
      locale: 'ja_JP'
    }
  end

	def ogp_url(text)
		return "https://res.cloudinary.com/#{Settings.cloudinary.cloud_name}/image/upload/l_text:Sawarabi%20Gothic_60:#{text},co_rgb:000,w_400,c_fit/v1626790569/ogp_plukpo.png"
	end

	def memo_show_page?
		params[:controller] == 'memos' && params[:action] == 'show'
	end

	def noindex?
		memo_show_page?
	end

	def title
		controller = params[:controller].split('/')
		action = params[:action]
		I18n.t((controller << action).join('.'))
	end
end
