class MartinScraper < ForumScraper
  def default_url
    "http://theunofficialmartinguitarforum.yuku.com/forums/23"
  end

  def default_sticky_posts
    3
  end

  # select how many pages back in history to scrape
  def page_count
    20
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
    title     = row.css('td')[2].text.strip.gsub(/\s{2,}/, ' ')
    replies   = row.css('td')[3].text.strip
    last_post = row.css('td')[4].text.strip.gsub(/\s{2,}/, ' ')
    author    = row.css('td')[5].text.strip
    link      = row.css('td a')[2]['href']
    views     = nil
    posts << OpenStruct.new(title: title, link: link, author: author, 
                 last_post: last_post, replies: replies, views: views)
  end

end