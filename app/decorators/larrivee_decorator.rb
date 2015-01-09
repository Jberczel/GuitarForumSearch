class LarriveeDecorator < Draper::Decorator
  delegate_all
  include ClassifiedsDecorations

  # larrivee links include base url
  def base_url
    ""
  end
end
