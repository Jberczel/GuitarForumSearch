require 'open-uri'
require 'ostruct'

class AgfScraper
  attr_reader :url, :forum, :sticky, :posts, :content, :page_count

  def initialize(args={})
    @url    = args.fetch(:url)
    @forum  = args.fetch(:forum)
    @sticky = args.fetch(:sticky, 6)
    @posts = []
  end

  def posts?
    !posts.empty?
  end

  def content
    @content ||= Nokogiri::HTML(open(url))
  end

  def page_count
    @page_count ||= 
      content.css('td.vbmenu_control').text.split(' ').last.to_i
  end

  def parse_pages
    return "Scrape Failed" unless scrapable?
    1.upto(page_count) do |i|
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
    rows = rows.drop(sticky) if page_num == 1
    parse_posts(rows)
  end

  def parse_forum_rows(page_num)
    page_url = url + "&num=#{page_num}"
    data     = Nokogiri::HTML(open(page_url))
    data.css("#threadbits_forum_#{forum} tr")
  end

  def parse_posts(rows)
    rows.each do |r|
      parse_post(r)
    end
  end

  def parse_post(row)
    title     = row.css('td')[2].css('div')[0].text.strip.gsub(/\s{2,}/, ' ')
    author    = row.css('td')[2].css('div')[1].text.strip.gsub(/\s{2,}/, ' ')
    last_post = row.css('td')[3].text.strip.gsub(/\s{2,}/, ' ')
    replies   = row.css('td')[4].text
    views     = row.css('td')[5].text
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
