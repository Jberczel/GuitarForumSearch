class Blueridge < ActiveRecord::Base
  extend PostUtils
  default_scope { order(:id) }
end
