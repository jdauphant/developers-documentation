class Jekyll::Converters::Markdown::Rows
  def initialize(config)
    @config = config
  end

  def convert(content)
    row_identifier = '--- row ---'
    col_identifier = '||| col |||'
    row_begin_tag = "<div class='row'>"
    row_end_tag   = '</div>'
    sidebar_text_begin_tag = "<div class='col-xs-12 col-sm-6 sidebar-text'>"
    sidebar_code_begin_tag = "<div class='col-xs-12 col-sm-6 sidebar-code'>"
    sidebar_code_begin_tag_alt = "<div class='hidden-xs col-xs-12 col-sm-6 sidebar-code'>"
    sidebar_end_tag = '</div>'

    content = content.split(row_identifier).map do |row|
      parts = row.split(col_identifier)
      parts << '' if parts.length.odd?
      row = parts.each_with_index.map do |value, index|
        value = Kramdown::Document.new(value, @config).to_html
        if index.even?
          if index == 0
            "#{sidebar_text_begin_tag} #{value}"
          else
            "#{sidebar_end_tag} #{row_end_tag} #{row_begin_tag} #{sidebar_text_begin_tag} #{value}"
          end
        else
          if value.empty?
            "#{sidebar_end_tag} #{sidebar_code_begin_tag_alt}"
          else
            "#{sidebar_end_tag} #{sidebar_code_begin_tag} #{value}"
          end
        end
      end.join('')

      "#{row} #{sidebar_end_tag}"
    end.join("#{row_end_tag} #{row_begin_tag}")
    value = "#{row_begin_tag} #{content} #{row_end_tag}"
    return value
  end
end
