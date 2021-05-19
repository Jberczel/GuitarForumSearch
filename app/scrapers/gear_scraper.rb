class GearScraper < AgfScraper
  def default_url
    "https://www.acousticguitarforum.com/forums/forumdisplay."\
    "php?f=54&pp=200&sort=lastpost&order=desc&daysprune=200"
  end

  def default_forum
    54
  end

  def default_sticky_posts
    4
  end
end
