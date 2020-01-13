def responsive_img_src(html_source)
    doc = Nokogiri::HTML::Document.parse('<html></html>', nil, 'UTF-8')
    fragment = Nokogiri::HTML::DocumentFragment.new(doc, html_source)
    fragment.css('img').each { |img| img['data-src'] = img['src'] }
    return fragment.to_html
  end