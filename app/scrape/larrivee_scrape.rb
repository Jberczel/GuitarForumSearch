require 'open-uri'
module LarriveeScrape 

 URL = "http://www.larriveeforum.com/smf/index.php?board=6."

  def scrape_create
    begin
      data = Nokogiri::HTML(open(URL)) 
    rescue StandardError=>e
      puts "Error: #{e}\nTest scrape failed."
    else
      destroy_all             # delete old records
      reset_pk_sequence       # reset primary key to 0
      scrape_pages(10)         # scrape last nth pages of larrivee forum
    end
  end

  def scrape_pages(pages)
     # exception handling for each page
    0.upto(pages) do |i|
      retries = 2
      puts "\tparsing page #{i}..."     
      begin     
        scrape_page(i)
        sleep 1
      rescue StandardError=>e
        puts "Error: #{e}\nWas not able to parse page #{i}."
        if retries > 0
          puts "Trying #{retries} more times"
          retries -= 1
          sleep 1
          retry
        end
      end      
    end
  end

  def scrape_page(page)
    page_url = URL + "#{page * 35}"           # 35 post per page
    data     = Nokogiri::HTML(open(page_url))
    rows     = data.css('.tborder tr')[1..-2] # exclude header and bottom nav row
    rows     = rows[3..-2] if page == 0       # exclude sticky posts
    parse_create_records(rows)
  end

  def parse_create_record(row)
    title     = row.css('td')[2].text.strip
    author    = row.css('td')[3].text.strip
    replies   = row.css('td')[4].text
    views     = row.css('td')[5].text
    last_post = row.css('td')[6].text.strip.gsub(/\s{2,}/, ' ')
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