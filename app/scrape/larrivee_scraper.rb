require 'open-uri'
require 'ostruct'

class LarriveeScraper
  attr_reader :url, :sticky, :posts, :content, :page_count

  def initialize(args={})
    @url    = args.fetch(:url)
    @sticky = args.fetch(:sticky, 3) 
    @page_count  = args.fetch(:page_count, 10)
    @posts = []
  end

  def posts?
    !posts.empty?
  end

  def content
    @content ||= Nokogiri::HTML(open(url))
  end

  # starts at 0, not 1
  def parse_pages
    return "Scrape Failed" unless scrapable?
    0.upto(page_count) do |i|
      puts "\tparsing page #{i}..."
      retry_parse(3) { parse_single_page(i) }
     end
  end

  private

  def scrapable?
    content && page_count
  end

  def parse_single_page(page_num)
    rows = parse_forum_rows(page_num)
    parse_posts(rows)
  end

  # most of the concrete data is here
  def parse_forum_rows(page_num)
    page_url = url + "#{page_num * 35}"       # 35 post per page
    data     = Nokogiri::HTML(open(page_url))
    rows     = data.css('.tborder tr')[1..-2] # exclude header and bottom nav row
    rows     = rows[sticky..-2] if page_num == 0  # exclude sticky posts
    rows
  end

  def parse_posts(rows)
    rows.each do |r|
      parse_post(r)
    end
  end

  def parse_post(row)
    title     = row.css('td')[2].text.strip
    author    = row.css('td')[3].text.strip
    replies   = row.css('td')[4].text
    views     = row.css('td')[5].text
    last_post = row.css('td')[6].text.strip.gsub(/\s{2,}/, ' ')
    link      = row.at_css('td a')['href']
    posts << OpenStruct.new(title: title, link: link, author: author, 
                 last_post: last_post, replies: replies, views: views)
  end

  def retry_parse(n)
    begin
      yield
      sleep 2
    rescue StandardError => e
      puts "Error: #{e}\nWas not able to parse page."
      raise e if n == 0
      retry_parse(n - 1)
    end
  end
end

