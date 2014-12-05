class Post < ActiveRecord::Base
  extend AgfScrape
  default_scope { order(:id) }

  def self.url
    "http://www.acousticguitarforum.com/forums/forumdisplay.php"\
    "?f=17&pp=200&sort=lastpost&order=desc&daysprune=200"
  end

  def self.forum
    17
  end

  def self.sticky_posts
    6
  end
  
end

