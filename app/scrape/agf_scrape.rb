require 'open-uri'
module AgfScrape

  # extenders may overide
  def url
    "http://www.acousticguitarforum.com/forums/forumdisplay.php"\
    "?f=17&pp=200&sort=lastpost&order=desc&daysprune=200"
  end

  # extenders may overide
  def forum
    17
  end

  # extenders may overide
  def sticky_posts
    6
  end

  # scrape guitar forum pages and create records in posts table
  def scrape_create
    begin
      data = Nokogiri::HTML(open(url))
      numPages = data.css('td.vbmenu_control').text.split(' ').last.to_i  
    rescue StandardError=>e
      puts "Error: #{e}, numPages: #{numPages}\nTest scrape failed."
    else
      destroy_all             # delete old records
      reset_pk_sequence       # reset primary key to 0
      scrape_pages(numPages)
    end
  end

  def scrape_pages(pages)
    1.upto(pages) do |i|
      puts "\tparsing page #{i}..."
      retry_parse(3) { scrape_page(i) }
     end
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

  def scrape_page(page)
    page_url = url + "&page=#{page}"
    data     = Nokogiri::HTML(open(page_url))
    rows     = data.css("#threadbits_forum_#{forum} tr")
    rows     = rows.drop(sticky_posts) if page == 1
    parse_create_records(rows)
  end

  def parse_create_record(row)
    title     = row.css('td')[2].css('div')[0].text.strip.gsub(/\s{2,}/, ' ')
    author    = row.css('td')[2].css('div')[1].text.strip.gsub(/\s{2,}/, ' ')
    last_post = row.css('td')[3].text.strip.gsub(/\s{2,}/, ' ')
    replies   = row.css('td')[4].text
    views     = row.css('td')[5].text
    link      = row.at_css('td a')['href']

    self.create!(title: title, link: link, author: author, 
                 last_post: last_post, replies: replies, views: views)
  end

  def parse_create_records(rows)
    rows.each do |r|
      parse_create_record(r)
    end
  end
end
   