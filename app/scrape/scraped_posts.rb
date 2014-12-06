module ScrapedPosts
  GUITARS = AgfScraper.new( 
              :url    => "http://www.acousticguitarforum.com/forums/forumdisplay."\
               "php?f=17&pp=200&sort=lastpost&order=desc&daysprune=200",
              :forum  => 17,
              :sticky => 6 )

  GEAR = AgfScraper.new(
           :url    => "http://www.acousticguitarforum.com/forums/forumdisplay.php"\
               "?f=54&pp=200&sort=lastpost&order=desc&daysprune=200",
           :forum  => 54,
           :sticky => 6 )

  LARRIVEE = LarriveeScraper.new(
               :url    => "http://www.larriveeforum.com/smf/index.php?board=6.",
               :sticky => 3)

  def self.create_posts(scraper, model)
    scraper.parse_pages
    if scraper.posts?
      model.clear_db
      model.create(scraper.posts)
    end
  end
end