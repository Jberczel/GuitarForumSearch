class GuitarScraper < AgfScraper
  def default_url
    "https://www.acousticguitarforum.com/forums/forumdisplay."\
    "php?f=17&pp=200&sort=lastpost&order=desc&daysprune=200"
  end

  def default_forum
    17
  end

  def default_sticky_posts
    3
  end
end
