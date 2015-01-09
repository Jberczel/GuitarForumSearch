class MartinDecorator < Draper::Decorator
  delegate_all
  include ClassifiedsDecorations

  def base_url
    "http://theunofficialmartinguitarforum.yuku.com"
  end
end
