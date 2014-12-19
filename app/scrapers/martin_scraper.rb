class MartinScraper < ForumScraper
  def default_url
    "http://theunofficialmartinguitarforum.yuku.com/forums/23"
  end

  def default_sticky_posts
    3
  end

  # select how many pages back in history to scrape
  def page_count
    4
  end

  private

  def parse_table(page_num)
    data = page_data(page_url(page_num))
    rows = table_rows(data)
    remove_sticky_posts(rows, page_num)
  end

  def page_url(page_num)
    "#{url}?page=#{page_num}"
  end

  def page_data(url)
    Nokogiri::HTML(open(url))
  end

  def table_rows(data)
    data.css(".boxbody tbody > tr")
  end

  def remove_sticky_posts(rows, page_num)
    page_num == 1 ? rows.drop(sticky_posts) : rows
  end

  def parse_single_post(row)
    fields    = row.css('td')
    title     = fields[2].text.gsub(/\s{2,}/, ' ')
    replies   = fields[3].text
    last_post = fields[4].text.gsub(/\s{2,}/, ' ')
    author    = fields[5].text.strip
    link      = row.css('td a')[2]['href']
    views     = nil
    posts << OpenStruct.new(title: title, link: link, author: author,
                 last_post: last_post, replies: replies, views: views)
  end
end
