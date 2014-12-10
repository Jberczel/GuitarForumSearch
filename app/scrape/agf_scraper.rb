class AgfScraper < ForumScraper
  attr_reader :forum

  def post_initialize(args)
    @forum = args[:forum] || default_forum 
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
    title     = row.css('td')[2].css('div')[0].text.strip.gsub(/\s{2,}/, ' ')
    author    = row.css('td')[2].css('div')[1].text.strip.gsub(/\s{2,}/, ' ')
    last_post = row.css('td')[3].text.strip.gsub(/\s{2,}/, ' ')
    replies   = row.css('td')[4].text
    views     = row.css('td')[5].text
    link      = row.at_css('td a')['href']
    posts << OpenStruct.new(title: title, link: link, author: author, 
                 last_post: last_post, replies: replies, views: views)
  end
end
