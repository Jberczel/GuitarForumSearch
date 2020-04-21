class AgfScraper < ForumScraper
  attr_reader :forum

  def post_initialize(args)
    @forum = args[:forum] || default_forum
  end

  def default_forum
    raise NotImplementedError, 'assign forum number in sublcass'
  end

  def page_count
    @page_count ||=
      content.css('td.vbmenu_control').text.split(' ').last.to_i
  end

  private

  def parse_table(page_num)
    data = page_data(page_url(page_num))
    rows = table_rows(data)
    remove_sticky_posts(rows, page_num)
  end

  def page_url(page_num)
    "#{url}&page=#{page_num}"
  end

  # stub in tests
  def page_data(url)
    Nokogiri::HTML(open(url))
  end

  def table_rows(data)
    data.css("#threadbits_forum_#{forum} tr")
  end

  def remove_sticky_posts(rows, page_num)
    page_num == 1 ? rows.drop(sticky_posts) : rows
  end

  def parse_single_post(row)
    fields    = row.css('td')
    title     = fields[2].css('div')[0].text.gsub(/\s{2,}/, ' ')
    author    = fields[2].css('div')[1].text.gsub(/\s{2,}/, ' ')
    last_post = fields[3].text.gsub(/\s{2,}/, ' ')
    replies   = fields[4].text
    views     = fields[5].text
    link      = row.at_css('div > a')['href']
    posts << OpenStruct.new(title: title, link: link, author: author,
                 last_post: last_post, replies: replies, views: views)
  end
end
