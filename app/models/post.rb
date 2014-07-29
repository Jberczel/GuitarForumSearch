class Post < ActiveRecord::Base

  def self.scrape
    require 'open-uri'
    url = "http://www.acousticguitarforum.com/forums/forumdisplay.php?f=17&pp=200&sort=lastpost&order=desc&daysprune=100"
    data = Nokogiri::HTML(open(url))

    # number of fourm pages to scrape
    count = data.css('td.vbmenu_control').text.split(' ').last.to_i 

    1.upto(count) do |i|

      page_url = url + "&page=#{i}"
      data = Nokogiri::HTML(open(page_url))
      rows = data.css('#threadbits_forum_17 tr')
      rows = rows[7..-1] if i == 1 # remove 'sticky notes' rows top of first page

      rows.each do |r|
        title       = r.css('td')[2].css('div')[0].text.strip.gsub(/\s{2,}/, ' ')
        author      = r.css('td')[2].css('div')[1].text.strip.gsub(/\s{2,}/, ' ')
        last_post   = r.css('td')[3].text.strip.gsub(/\s{2,}/, ' ')
        replies     = r.css('td')[4].text
        views       = r.css('td')[5].text
        link        = r.at_css('td a')['href']

        Post.create!( title: title, link: link, author: author, last_post: last_post,
                      replies: replies, views: views)
      end
    end
  end

  # used with previous search form; replace with dataTables plugin
  def self.search(search)
    if search
      where("title ILIKE ?", "%#{search}%")
    else
      all
    end
  end

end
