module Jekyll
  module ToC
    def toc(content)
      content = Kramdown::Document.new(content,[]).to_html
      content = ::Nokogiri::HTML(content)
      values = content.css('//h1')
      values = content.css('//h2') if values.length <= 1

      return values.map do |v|
        { 'text' => v.text, 'id' => v.attr('id') }
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::ToC)
