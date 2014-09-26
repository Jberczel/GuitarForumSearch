class Gear < ActiveRecord::Base
  default_scope { order(:id) }

  URL = "http://www.acousticguitarforum.com/forums/forumdisplay.php"\
        "?f=54&pp=200&sort=lastpost&order=desc&daysprune=200"

  # scrape guitar forum pages and create records in posts table
  def self.scrape_create
    require 'open-uri' 
    begin
      data = Nokogiri::HTML(open(URL))
      test_page_scrape(data)
      numPages = data.css('td.vbmenu_control').text.split(' ').last.to_i  
    rescue StandardError=>e
      puts "Error: #{e}, numPages: #{numPages}"
      puts "Test scrape failed."
    else
      destroy_all             # delete old records
      reset_pk_sequence       # reset primary key to 0
      scrape_pages(numPages)
    end
  end

  private
    def self.scrape_pages(pages)
       # exception handling for each page
      1.upto(pages) do |i|
        retries = 2
        puts "\tparsing page #{i}..."     
        begin     
          scrape_page(i)
          sleep 2
        rescue StandardError=>e
          puts "Error: #{e}"
          puts "Was not able to parse page #{i}."
          if retries > 0
            puts "Trying #{retries} more times"
            retries -= 1
            sleep 2
            retry
          end
        end      
      end
    end

    def self.scrape_page(page)
      page_url = URL + "&page=#{page}"
      data     = Nokogiri::HTML(open(page_url))
      rows     = data.css('#threadbits_forum_54 tr') # ALERT: forum number here
      rows     = rows[6..-1] if page == 1   # exclude sticky topics on first page
      parse_create_records(rows)
    end

    def self.parse_create_record(row)
      title     = row.css('td')[2].css('div')[0].text.strip.gsub(/\s{2,}/, ' ')
      author    = row.css('td')[2].css('div')[1].text.strip.gsub(/\s{2,}/, ' ')
      last_post = row.css('td')[3].text.strip.gsub(/\s{2,}/, ' ')
      replies   = row.css('td')[4].text
      views     = row.css('td')[5].text
      link      = row.at_css('td a')['href']

      Gear.create!(title: title, link: link, author: author, 
                    last_post: last_post, replies: replies, views: views)
    end

    def self.parse_create_records(rows)
      rows.each do |r|
        parse_create_record(r)
      end
    end

    # test if app can scrape a thread and create record
    def self.test_page_scrape(data)
      #### ALERT: forum number needs to change!!!!!!
      # row = data.css('#threadbits_forum_17 tr')[7]  # skip first 7 sticky threads
      row = data.css('#threadbits_forum_54 tr')[7] 
      parse_create_record(row)
    end
end
