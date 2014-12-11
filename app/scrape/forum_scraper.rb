require 'open-uri'
require 'ostruct'

class ForumScraper
  attr_reader :url, :sticky_posts, :posts, :content

  def initialize(args={})
    @url          = args[:url]    || default_url
    @sticky_posts = args[:sticky] || default_sticky_posts
    @posts        = []
    post_initialize(args)
  end

  def default_url
    "http://www.google.com"
  end

  def default_sticky_posts
    6
  end

  # subclasses may override
  def post_initialize(args)
    nil
  end

  def posts?
    !posts.empty?
  end

  def content
    @content ||= Nokogiri::HTML(open(url))
  end

  # initialize in subclasses
  def page_count
    raise NotImplementedError
  end

   def parse_pages
    return "Scrape Failed" unless scrapable?
    1.upto(page_count) do |i|
      puts "\tparsing page #{i}..."
      retry_parse(3) { parse_single_page(i) }
    end
    self
  end

  def create_posts(model)
    return "No posts to create" unless posts?
    model.clear_db
    model.create(posts)
    self
  end

  private

  def scrapable?
    content && page_count
  end

  def parse_single_page(page_num)
    data_table = parse_table(page_num)
    parse_posts(data_table)
  end

  # parse html table, page_num is url parameter
  def parse_table(page_num)
    raise NotImplementedError
  end

  # parse single row in html table
  def parse_single_post(row)
    raise NotImplementedError
  end

  def parse_posts(rows)
    rows.each do |r|
      parse_single_post(r)
    end
  end

  def retry_parse(n)
    begin
      yield
    rescue StandardError => e
      puts "Error: #{e}\nWas not able to parse page."
      raise e if n == 0
      retry_parse(n - 1)
    end
  end
end
