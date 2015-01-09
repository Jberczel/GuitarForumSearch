class BlueridgeDecorator < Draper::Decorator
  delegate_all
  include ClassifiedsDecorations

  def base_url
    "http://theunofficialblueridgeguitarforum18213.yuku.com"
  end
end
