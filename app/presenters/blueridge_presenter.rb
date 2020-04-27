class BlueridgePresenter < BasePresenter
  include ClassifiedsPresenter

  def base_url
    # links include base_url, so we omit base_url when presenting blueridge links
    ""
  end

end
