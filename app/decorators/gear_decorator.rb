class GearDecorator < Draper::Decorator
  delegate_all
  include ClassifiedsDecorations

  def base_url
    "http://www.acousticguitarforum.com/forums/"
  end
end
