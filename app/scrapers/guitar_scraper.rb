class GuitarScraper < AgfScraper
  def default_url
    "http://www.acousticguitarforum.com/forums/forumdisplay."\
    "php?f=17&pp=200&sort=lastpost&order=desc&daysprune=200"
  end

  def default_forum
    17
  end

  def default_sticky_posts
    7
  end
end
