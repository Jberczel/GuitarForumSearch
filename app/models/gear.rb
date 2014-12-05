class Gear < ActiveRecord::Base
  extend AgfScrape
  default_scope { order(:id) }

  # scrape config
  def self.url
    "http://www.acousticguitarforum.com/forums/forumdisplay.php"\
    "?f=54&pp=200&sort=lastpost&order=desc&daysprune=200"
  end

  def self.sticky_posts
    6
  end

  # scrape config
  def self.forum
    54
  end
end
