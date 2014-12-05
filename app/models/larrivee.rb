class Larrivee < ActiveRecord::Base
  extend LarriveeScrape
  default_scope { order(:id) }
end
