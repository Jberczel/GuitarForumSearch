class LarriveeScraper < ForumScraper
  def default_url
    "http://www.larriveeforum.com/smf/index.php?board=6."
  end

  def default_sticky_posts
    3
  end

  # select how many pages back in history to scrape
  def page_count
    10
  end

  private

  def parse_table(page_num)
    data = page_data(page_url(page_num))
    rows = table_rows(data)
    remove_sticky_posts(rows, page_num)
  end

  def page_data(url)
    Nokogiri::HTML(open(url))
  end

  def page_url(page_num)
    "#{url}#{(page_num - 1) * 35}"  # 35 posts per page
  end

  def table_rows(data)
    data.css('.tborder tr')[1..-2] # exclude header and bottom nav rows
  end

  def remove_sticky_posts(data, page_num)
    page_num == 1 ? data[sticky_posts..-1] : data
  end

  def parse_single_post(row)
    title     = row.css('td')[2].text.strip
    author    = row.css('td')[3].text.strip
    replies   = row.css('td')[4].text
    views     = row.css('td')[5].text
    last_post = row.css('td')[6].text.strip.gsub(/\s{2,}/, ' ')
    link      = row.at_css('td a')['href']
    posts << OpenStruct.new(title: title, link: link, author: author, 
                 last_post: last_post, replies: replies, views: views)
  end
end

