class Larrivee < ActiveRecord::Base
  default_scope { order(:id) }

  URL = "http://www.larriveeforum.com/smf/index.php?board=6."

  def self.scrape_create
    require 'open-uri' 
    begin
      data = Nokogiri::HTML(open(URL))
      test_page_scrape(data)
      # numPages = data.css('td.vbmenu_control').text.split(' ').last.to_i  
    rescue StandardError=>e
      puts "Error: #{e}"
      puts "Test scrape failed."
    else
      destroy_all             # delete old records
      reset_pk_sequence       # reset primary key to 0
      scrape_pages(10)         # scrape last nth pages of larrivee forum
    end
  end

  private
    def self.scrape_pages(pages)
       # exception handling for each page
      0.upto(pages) do |i|
        retries = 2
        puts "\tparsing page #{i}..."     
        begin     
          scrape_page(i)
          sleep 1
        rescue StandardError=>e
          puts "Error: #{e}"
          puts "Was not able to parse page #{i}."
          if retries > 0
            puts ".Trying #{retries} more times"
            retries -= 1
            sleep 2
            retry
          end
        end      
      end
    end

    def self.scrape_page(page)
      page_url = URL + "#{page * 35}" # 35 post per page
      data     = Nokogiri::HTML(open(page_url))
      rows     = data.css('.tborder tr')
      rows     = page == 0 ? rows[3..-2] : rows[1..-2]   # exclude sticky topics on first page and bottom nav
      parse_create_records(rows)
    end

    def self.parse_create_record(row)
      title     = row.css('td')[2].text.strip
      author    = row.css('td')[3].text.strip
      replies   = row.css('td')[4].text
      views     = row.css('td')[5].text
      last_post = row.css('td')[6].text.strip.gsub(/\s{2,}/, ' ')
      link      = row.at_css('td a')['href']

      Larrivee.create!(title: title, link: link, author: author, 
                    last_post: last_post, replies: replies, views: views)
    end

    def self.parse_create_records(rows)
      rows.each do |r|
        parse_create_record(r)
      end
    end

    # test if app can scrape a thread and create record
    def self.test_page_scrape(data)
      row = data.css('.tborder tr')[3]  # skip first 3 sticky threads
      parse_create_record(row)
    end
end
