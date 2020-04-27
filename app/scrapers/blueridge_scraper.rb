class BlueridgeScraper < ForumScraper
  def default_url
    "https://www.tapatalk.com/groups/theunofficialblueridgeguitarforum18213/for-sale-or-trade-f71/"
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

  def page_url(page_num)
    pagination = "index-s#{(page_num - 1) * 25}.html"
    page_num > 1 ? "#{url}/#{pagination}" : url
  end

  def page_data(url)
    Nokogiri::HTML(open(url))
  end

  def table_rows(data)
    data.css(".topics > li")
  end

  def remove_sticky_posts(rows, page_num)
    page_num == 1 ? rows.drop(sticky_posts) : rows
  end

  def parse_single_post(row)
    title     =  row.at_css('.topictitle')
    replies   =  row.at_css('.posts')
    views     =  row.at_css('.views')
    last_post =  row.at_css('.lastpost')
    author    =  row.at_css('.username')
    link      =  row.at_css('a.topictitle')

    posts << OpenStruct.new(
      title:     title ? title.text : "",
      link:      link ? link['href'] : "",
      author:    author ? author.text : "",
      last_post: last_post ? last_post.text : "",
      replies:   replies ? replies.text.gsub('Replies', '') : "",
      views:     views ? views.text.gsub('Views', '') : ""
    )
  end
end
