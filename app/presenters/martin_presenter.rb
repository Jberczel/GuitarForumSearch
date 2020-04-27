class MartinPresenter < BasePresenter
  include ClassifiedsPresenter

  def base_url
    # links include full path, so omit base_url for martin presenter
    ""
  end

end
