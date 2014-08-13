class Post < ActiveRecord::Base

  # scrape guitar forum pages and create records in posts table
  def self.scrape_create
    require 'open-uri'
    url = "http://www.acousticguitarforum.com/forums/forumdisplay.php"
    url << "?f=17&pp=200&sort=lastpost&order=desc&daysprune=100"
    
    begin
      data = Nokogiri::HTML(open(url))
      # get a single guitar listing (skip first 7 sticky topics on forum)
      listing = data.css('#threadbits_forum_17 tr')[7]
      parse_create_record(listing)
      # number of fourm pages to scrape
      numPages = data.css('td.vbmenu_control').text.split(' ').last.to_i    
    rescue StandardError=>e
      puts "Error: #{e}"
      puts "Test parse failed."
    else
      destroy_all         # delete old records
      reset_pk_sequence   # reset primary key to 0

       # exception handling for each page
      1.upto(numPages) do |i|
        retries = 2
        puts "\tparsing page #{i}..."
       
        begin     
          page_url = url + "&page=#{i}"
          data = Nokogiri::HTML(open(page_url))
          listings = data.css('#threadbits_forum_17 tr')
          listings  = listings[7..-1] if i == 1   # exclude sticky topics on first page
          parse_create_records(listings)
        rescue
          puts "Error: #{e}"
          puts "Was not able to parse page #{i}."
          if retries > 0
            puts ".Trying #{retries} more times"
            retries -= 1
            sleep 1
            retry
          end
        end      
      end
    end
  end


  private
    def self.parse_create_record(row)
      title     = row.css('td')[2].css('div')[0].text.strip.gsub(/\s{2,}/, ' ')
      author    = row.css('td')[2].css('div')[1].text.strip.gsub(/\s{2,}/, ' ')
      last_post = row.css('td')[3].text.strip.gsub(/\s{2,}/, ' ')
      replies   = row.css('td')[4].text
      views     = row.css('td')[5].text
      link      = row.at_css('td a')['href']

      Post.create!(title: title, link: link, author: author, 
                    last_post: last_post, replies: replies, views: views)
    end

    def self.parse_create_records(rows)
      rows.each do |r|
        parse_create_record(r)
      end
    end
end

